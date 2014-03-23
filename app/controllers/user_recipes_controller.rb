class UserRecipesController < ApplicationController
  def index
    if current_user
      user = User.find(params[:user_id])
      @recipes = user.recipes
    else
      redirect_to '/'
    end
  end

  def create
    ScheduledRecipe.create(recipe_params)
    redirect_to '/'
  end

  private
  def recipe_params
    params.permit(:day, :recipe_id, :user_id)
  end
end
