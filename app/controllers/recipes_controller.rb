class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    @page_title = "#{@recipe.name} Recipe"
    if request.path != recipe_path(@recipe)
      redirect_to recipe_path(@recipe), :status => :moved_permanently
    end
  end

  def index
    limit = 10
    @subheader = "#{limit} Random Recipes"
    @recipes = Recipe.order('random()').limit(limit)
  end

  def all_recipes
    @recipes = Recipe.order('name ASC')
  end

  def recipe_search
    @subheader = "'#{params[:q]}' Recipes"
    @recipes = Recipe.where("LOWER(name) like LOWER('%#{params[:q]}%')")
    render :all_recipes
  end

  def ingredient_search
    @subheader = "'#{params[:q]}' ingredient Recipes"
    @recipes = Recipe.joins(:ingredients).select('distinct(recipes.id), recipes.*').where("ingredients.name like '%#{params[:q]}%'")
    render :all_recipes
  end

  def random_recipes
    @recipes = Recipe.order('rand()').limit(10)
    render @recipes
  end

end
