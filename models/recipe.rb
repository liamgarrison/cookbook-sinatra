class Recipe
  attr_reader :name, :description, :prep_time, :done, :id
  def initialize(recipe_details)
    @name = recipe_details[:name]
    @description = recipe_details[:description]
    @prep_time = recipe_details[:prep_time]
    @done = recipe_details[:done]
    @id = recipe_details[:id]
  end

  def mark_done
    @done = true
  end
end
