require 'spec_helper'

describe RecipesController, type: :controller do

  describe "GET 'show'" do
    it "returns http success" do
      recipe = Recipe.create!(name: "test")
      get 'show', params: {id: "#{recipe.id}-test"}
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
