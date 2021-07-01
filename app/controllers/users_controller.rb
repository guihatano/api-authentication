# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def update
    if current_user.update(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
end