class Recipe < ActiveRecord::Base

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :name, presence: true
  validates :directions, presence: true

  # validates_presence_of :creator_id

  def self.search(search) do
    if search == 'search_recipe_name'
      @recipes = Recipe.where("name ILike '%?%'", params[:search]) #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    elsif search == 'search_ingredient'
      @recipes = Ingredient.includes(:recipes).where("name is ILike '%?%'", params[:seach]).first.recipes
    else
      @recipes = Recipe.take(20)
    end
  end
end


# @ingredient = Ingredient.includes(:recipes).where("name is ILike %params[:name]").first.recipes
