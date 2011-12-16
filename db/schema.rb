# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111216051929) do

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "user_name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredient_recipes", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.string   "amount"
    t.string   "preparation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredient_recipes", ["ingredient_id"], :name => "index_ingredient_recipes_on_ingredient_id"
  add_index "ingredient_recipes", ["recipe_id"], :name => "index_ingredient_recipes_on_recipe_id"

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["name"], :name => "index_ingredients_on_name", :unique => true

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.text     "method"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["name"], :name => "index_recipes_on_name"

end
