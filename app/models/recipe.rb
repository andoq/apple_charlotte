require 'aws-sdk-s3'

class Recipe < ActiveRecord::Base

  has_many :ingredient_recipes
  has_many :ingredients, :through => :ingredient_recipes

  has_many :comments, :as => :commentable

  serialize :method
  serialize :notes

  def related
    ingredient_ids = self.ingredient_ids

    related_recipes = Recipe.select("recipes.*, count(ingredient_recipes.id)")
                          .joins(:ingredient_recipes)
                          .where("ingredient_recipes.ingredient_id in (?)", ingredient_ids)
                          .where("recipes.id <> ?", self.id)
                          .group("recipes.id")
                          .order("count(ingredient_recipes.id) DESC")
    # order by count(ir.id) DESC, ingredient_ids)

    return related_recipes
  end

  def as_json
    return {
        id: self.id,
        name: self.name.to_json,
        method: self.method.to_json,
        notes: self.notes.to_json,
        ingredients: self.ingredients.as_json
    }
  end

  def self.export_to_csv(file_path = nil)
    recipes = self.all
    if file_path
        File.open(file_path, "wb") do |f|
          f.write(JSON.pretty_generate(recipes.as_json))
        end
    else
      s3 = Aws::S3::Resource.new(region: 'us-west-2')
      bucket = s3.bucket('apple-char-data')
      bucket.object('andy.json').put({body: JSON.pretty_generate(recipes.as_json)})
    end

    return true
  end

  def self.import_from_html(filename)

    p filename
    return unless File.file?(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes', filename))
    doc = open(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes', filename)) { |f| Hpricot(f) }
    p "name: #{(doc/"h1").inner_html}"

    recipe = Recipe.create!(:name => get_text(doc/"h1"))
    ingredients = (doc/"#ingredients")

    (ingredients/"li").each do |li|
      #TODO: extract ingredient amount from string
      ingredient = Ingredient.find_or_create_by_name(get_text(li))
      recipe.ingredients << ingredient
    end

    method = (doc/"#method")

    methods = []

    (method/"li").each do |li|
      #TODO: put items into a strucutured DB object
      methods << get_text(li)
    end

    recipe.method = methods

    recipe.save!

    notes = (doc/"#notes")

    notes_array = []

    (notes/"p").each do |p|
      #TODO: put items into a strucutured DB object
      notes_array << get_text(p)
    end

    recipe.notes = notes_array

    recipe.save!

    true
  end

  def self.import_all
    ActiveRecord::Base.connection.execute('Truncate recipes')
    ActiveRecord::Base.connection.execute('Truncate ingredients')
    ActiveRecord::Base.connection.execute('Truncate ingredient_recipes')

    to_html_location = File.join(Rails.root, 'data')
    recipes_location = File.join(to_html_location, 'recipes')
    Dir.foreach(recipes_location) do |filename|
      File.delete(filename) if File.file?(filename)
    end

    #TODO: in the future, use ruby to read in the all.txt file.  But for now, the perl script is working great, and
    #structures all the data nicely, so first run it through that, and the import from html.

    system("cd #{to_html_location} && perl tohtml.pl < all.txt")

    Dir.foreach(recipes_location) do |filename|
      import_from_html(filename)
    end
  end

  def self.html_coder
    require 'htmlentities' unless defined? HTMLEntities
    @@html_coder ||= HTMLEntities.new
  end

  def self.get_text(element)
    html_coder.decode(element.inner_html.gsub('&Acirc;', ''))
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
