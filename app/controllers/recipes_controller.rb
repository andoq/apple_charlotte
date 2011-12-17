class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index
    @subheader = "20 Random Recipes"
    @recipes = Recipe.order('rand()').limit(20)
  end

  def all_recipes
    @recipes = Recipe.order('name ASC')
  end

  def recipe_search
    @subheader = "'#{params[:q]}' Recipes"
    @recipes = Recipe.where("name like '%#{params[:q]}%'")
    render :all_recipes
  end

  def ingredient_search
    @subheader = "'#{params[:q]}' ingredient Recipes"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:q]}%'")
    render :all_recipes
  end

  def random_recipes
    @recipes = Recipe.order('rand()').limit(20)
    render @recipes
  end

end
