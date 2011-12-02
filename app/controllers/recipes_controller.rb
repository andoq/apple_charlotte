class RecipesController < ApplicationController
  def show
    render :file => "recipes/recipes/#{params[:id]}.html"
  end

  def index
  end

end
