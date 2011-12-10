class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.limit(100)
    @recipes = @recipes.where("name like '%#{params[:recipe_name]}%'") if params[:recipe_name]
    if params[:ingredient_name]
      @recipes = Recipe.joins(:ingredients).where("ingredients.name like '%#{params[:ingredient_name]}%'")
    end
  end

end
