class Ingredient < ActiveRecord::Base

  has_many :ingredient_recipes
  has_many :recipes, :through => :ingredient_recipes

  def as_json
    return {
        id: self.id,
        name: self.name,
    }
  end

end
