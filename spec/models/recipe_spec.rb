require 'spec_helper'

describe Recipe do
  describe "#import_from_html" do

    skip "should open an .html file" do
      Recipe.import_from_html
      Recipe.all.size.should > 0
    end

  end

  describe "hack" do
    it "should run" do
      @file_path = "andy.json"
      File.delete(@file_path) if File.exists?(@file_path)
      recipe = Recipe.create!(name: "test")
      # Ingredient.create!(name: "ingredient")
      recipe.ingredients.create!(name: "ingredient")
      response = Recipe.export_to_csv()
    end
  end
end
