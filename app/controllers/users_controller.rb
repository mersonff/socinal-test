# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def show
    render @user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    render json: @user.errors.messages, status: :unprocessable_entity unless @user.update(user_params)
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :nickname, roles_attributes: %i[id name _destroy])
  end
end
