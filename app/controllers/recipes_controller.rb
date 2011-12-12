class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:ingredient_name]}%'")
    #@recipes = Recipe.all
  end

  def recipe_search
    @recipes = Recipe.where("name like '%#{params[:q]}%'")
    render :index
  end

  def ingredient_search
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:q]}%'")
    render :index
  end

end
