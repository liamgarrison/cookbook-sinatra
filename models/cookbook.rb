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

  def remove_recipe(id)
    @recipes.reject! { |recipe| recipe.id.to_s == id }
    csv_save
  end

  def mark_recipe_done(index)
    @recipes[index].mark_done
    csv_save
  end

  def find_by_id(id)
    @recipes.select { |recipe| recipe.id == id }[0]
  end

  private

  def csv_save
    CSV.open(@path_to_csv, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.done, recipe.id]
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
          done: row[3],
          id: row[4]
        })
    end
  end
end
