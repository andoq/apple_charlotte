Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'recipes/search/' => 'recipes#recipe_search', :as => :recipe_search
  get 'ingredients/search/' => 'recipes#ingredient_search', :as => :ingredient_search

  get '/recipes/all' => 'recipes#all_recipes', :as => :all_recipes
  get '/recipes/random' => 'recipes#random_recipes', :as => :random_recipes

  resources :recipes do
    resources :comments, :only => :create
  end
  resources :comments do
    get 'form', :on => :collection
  end

  root :to => 'recipes#index'
end
