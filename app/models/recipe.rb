class Recipe < ActiveRecord::Base

  has_many :ingredient_recipes
  has_many :ingredients, :through => :ingredient_recipes

  serialize :method
  serialize :notes

  def self.import_from_html(filename)
    p filename
    return unless File.file?(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes', filename))
    doc = open(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes', filename)) { |f| Hpricot(f) }
    p "name: #{(doc/"h1").inner_html}"

    recipe = Recipe.create!(:name => (doc/"h1").inner_html)

    ingredients = (doc/"#ingredients")

    (ingredients/"li").each do |li|
      #TODO: extract ingredient amount from string
      ingredient = Ingredient.find_or_create_by_name(li.inner_html)
      recipe.ingredients << ingredient
    end

    method = (doc/"#method")

    methods = []

    (method/"li").each do |li|
      #TODO: put items into a strucutured DB object
      methods << li.inner_html
    end

    recipe.method = methods

    recipe.save!

    notes = (doc/"#notes")

    notes_array = []

    (notes/"p").each do |p|
      #TODO: put items into a strucutured DB object
      notes_array << p.inner_html
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
    system("cd #{to_html_location} && perl tohtml.pl < all.txt")

    Dir.foreach(recipes_location) do |filename|
      import_from_html(filename)
    end
  end

end
