require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'models/cookbook'
require_relative 'models/recipe'
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('__dir__', __FILE__)
end

cookbook = Cookbook.new

get '/' do
  # Get all recipes from cookbook
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  # Display the form here
  erb :new
end

post '/recipes' do
  # Add the recipe from the form data
  new_recipe_details = {
    name: params["name"],
    description: params["description"],
    prep_time: params["prep_time"]
  }
  new_recipe = Recipe.new(new_recipe_details)
  cookbook.add_recipe(new_recipe)
  redirect '/'
end
