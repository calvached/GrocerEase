require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :scheduled_recipes
  has_many :users, through: :scheduled_recipes

  has_one :nutrition_information

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  # after_create :get_nutrition_information

  def get_nutrition_information
    nutrition = query_edamam
    # binding.pry
    args = {}
    args["recipe_id"] = self.id
    nutrition.each do |field, value|
      args[field] = value unless value.is_a? Array || value.is_a? Hash
    end

    nutrirtion_information = NutritionInformation.create(args)
    nutrition["healthLabels"].each { |label_name| HealthLabel.create(nutrition_information_id: nutrition_information.id, label_name: label_name)}

  # end

  def query_edamam

    params = {title: self.name,"yield" => self.serving_size.to_s, ingr: self.ingredients.map(&:name)}.to_json
    uri = URI.parse("https://api.edamam.com/api/nutrient-info?extractOnly&app_id=#{ENV["EDAMAM_APP_ID"]}&app_key=#{ENV["EDAMAM_APP_KEY"]}")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.content_type = "application/json"
    request.body = params
    response = https.request(request)

    begin
      return JSON.parse(@json_response)
    rescue Exception => e
      puts e.message
      puts "retrying.."
      retry
    end

  end

  def collect_ingredients_quantities_units
    recipe_ingredients = self.ingredients
    recipe_ingredients_qty_units = {}
    recipe_ingredients.each do |ingredient|
      join_record = RecipeIngredient.where(ingredient_id: ingredient.id, recipe_id: self.id).first
      qty = join_record.ingredient_quantity
      unit = join_record.measuring_unit
      recipe_ingredients_qty_units[ingredient] = {qty: qty, unit: unit}
    end
    recipe_ingredients_qty_units
  end

  def self.search(search, method)
    if method == "recipe_name"
      @recipes = Recipe.where("name ILike ?", "%#{search}%")
    elsif method == "ingredient"
      @recipes = []
      @ingredients = Ingredient.where("name ILike ?", "%#{search}%")
      @ingredients.each do |ingredient|
        @recipes += ingredient.recipes
      end
      @recipes
    else
      @recipes = Recipe.take(20)
    end
  end

  def self.import_recipes(query)
    recipe = get_recipe_from_yummly(query)
    recipe_id = recipe.matches.first["id"]
    # ingredients_arr = recipe.matches.first["ingredients"]
    recipe_details = get_details_from_yummly(recipe_id)
    ingredients_quantity = recipe_details.json['ingredientLines']
    serving_size = recipe_details.json['numberOfServings']
    recipe_name = recipe.matches.first["recipeName"]
    recipe_directions = recipe_details.json['source']['sourceRecipeUrl']
    recipe_image = recipe_details.json['images'].first['hostedLargeUrl']

    recipe = Recipe.create(name: recipe_name,
                  directions: recipe_directions,
                  img_path: recipe_image,
                  serving_size: serving_size)

    ingredients_quantity.each do |ingredient|
      recipe.ingredients << Ingredient.create(name: ingredient)
    end
  end

  def self.get_recipe_from_yummly(query)
    Yummly.search(query, {max: 1})
  end

  def self.get_details_from_yummly(recipe_id)
    Yummly.find(recipe_id)
  end


 def nutrition_calc
   attributes = {
     :calories => "calories",
     :total_fat => "total fat",
     :fa_sat => "saturated fat",
     :fa_mono => "monounsaturated fat",
     :fa_poly => "polyunsaturated fat",
     :cholestrl => "cholesterol",
     :carbs => "carbohydrates",
     :sugars => "sugars",
     :fiber => "dietary fiber",
     :protein => "protein"
     }
  end

  
  
end

