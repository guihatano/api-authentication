# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  # @route GET /api/user {format: :json} (user)
  def show; end

  # @route PATCH /api/user {format: :json} (user)
  # @route PUT /api/user {format: :json} (user)
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
