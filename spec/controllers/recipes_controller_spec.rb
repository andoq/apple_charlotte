require 'spec_helper'

describe RecipesController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => 'BraisedThaiChickenLegsontheGrill'
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
