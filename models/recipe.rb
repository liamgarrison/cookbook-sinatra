class Recipe
  attr_reader :name, :description, :prep_time, :done
  def initialize(recipe_details)
    @name = recipe_details[:name]
    @description = recipe_details[:description]
    @prep_time = recipe_details[:prep_time]
    @done = recipe_details[:done]
  end

  def mark_done
    @done = true
  end
end
