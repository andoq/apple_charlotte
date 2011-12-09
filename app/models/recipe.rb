class Recipe < ActiveRecord::Base

  has_many :ingredient_recipes
  has_many :ingredients, :through => :ingredient_recipes

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

    #(doc/"h2").each do |h2|
    #  case h2.inner_html
    #    when 'Ingredients'
    #      p "Ingredients: "
    #      ul =  h2.next.next #an extra new line to get around
    #      (h2.next.next/"li").each do |ingredient|
    #        p ingredient.inner_html.gsub!("\n", '')
    #      end
    #    when 'Method'
    #      p 'Methods: '
    #      ul = h2.next
    #      (h2.next/"li").each do |step|
    #        p step.inner_html.gsub!("\n", '')
    #      end
    #    when 'Notes'
    #      p 'Notes:'
    #      p_tag = h2.next
    #
    #      while (p_tag)
    #        if p_tag.name == "p"
    #          p p_tag.inner_html.gsub!("\n", '')
    #        end
    #        p_tag = p_tag.next
    #      end
    #  end
    #end

    true
  end

  def self.import_all
    ActiveRecord::Base.connection.execute('Truncate recipes')
    Dir.foreach(File.join(Rails.root, 'app', 'views', 'recipes', 'recipes')) do |filename|
      #p filename
      import_from_html(filename)
    end
  end

  def self.import_from_txt
    ActiveRecord::Base.connection.execute('Truncate recipes')
    counter = 0
    io = File.new(File.join(Rails.root, 'data', 'all.txt'))
    recipe = nil
    while line
      if (line.index('========='))
        recipe.save! if recipe
        recipe = Recipe.new()
        counter = counter + 1
        recipe.name = io.gets
      end

      if (line =~ /^INGREDIENTS:/)

      end
    end
    recipe.save!
    counter
  end

  def self.header_line?
    return true if line =~ /^INGREDIENTS:|^METHOD:|^Description:|Servings:|Source:|Yield:|Notes:/
  end



end
