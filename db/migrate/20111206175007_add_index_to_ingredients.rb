class AddIndexToIngredients < ActiveRecord::Migration
  def change
    add_index :ingredients, :name, :unique => true
    add_index :recipes, :name
    add_index :ingredient_recipes, :ingredient_id
    add_index :ingredient_recipes, :recipe_id
  end
end
