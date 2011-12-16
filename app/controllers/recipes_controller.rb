class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @subheader = "Recipes"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:ingredient_name]}%'")
    #@recipes = Recipe.all
  end

  def recipe_search
    @subheader = "'#{params[:q]}' Recipes"
    @recipes = Recipe.where("name like '%#{params[:q]}%'")
    render :index
  end

  def ingredient_search
    @subheader = "'#{params[:q]}' ingredient Recipes"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:q]}%'")
    render :index
  end

end
