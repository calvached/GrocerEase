class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :grocery_list

  has_many :created_recipes, class_name: "Recipe",  foreign_key: "creator_id"

  has_many :scheduled_recipes
  has_many :upcoming_week_recipes, through: :scheduled_recipes, :source => :recipe

  has_many :collected_recipes, foreign_key: :collector_id
  has_many :recipes, through: :collected_recipes

  after_create :create_grocery_list

  def create_grocery_list
    GroceryList.create(user_id: self.id, name: "GroceryList")
  end
end
