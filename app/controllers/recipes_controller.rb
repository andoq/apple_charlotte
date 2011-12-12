class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @subheader = "All Recipes"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:ingredient_name]}%'")
    #@recipes = Recipe.all
  end

  def recipe_search
    @subheader = "Recipes with '#{params[:q]}' in their name"
    @recipes = Recipe.where("name like '%#{params[:q]}%'")
    render :index
  end

  def ingredient_search
    @subheader = "Recipes with '#{params[:q]}' in an ingredient name"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:q]}%'")
    render :index
  end

end
