require "csv"
require_relative "recipe"

class Cookbook
  def initialize
    @recipes = []
    @path_to_csv = "models/recipes.csv"
    csv_load
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    csv_save
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    csv_save
  end

  def mark_recipe_done(index)
    @recipes[index].mark_done
    csv_save
  end

  private

  def csv_save
    CSV.open(@path_to_csv, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done]
      end
    end
  end

  def csv_load
    CSV.foreach(@path_to_csv, force_quotes: true) do |row|
      # row => [name, description]
      # Create new recipe instance from each row
      @recipes << Recipe.new({
          name: row[0],
          description: row[1],
          prep_time: row[2],
          done: row[3]
        })
    end
  end
end
