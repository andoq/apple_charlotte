class CreateIngredientRecipes < ActiveRecord::Migration
  def change
    create_table :ingredient_recipes do |t|
      t.references :recipe
      t.references :ingredient
      t.string     :amount
      t.string     :preparation
      t.timestamps
    end
  end
end
