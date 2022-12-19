# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_user
  before_action :set_role, only: %i[show update destroy]

  def show
    render @role
  end

  def update
    if @role.update(role_params)
      render json: @role
    else
      render json: @role.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy

    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_role
    @role = @user.role
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
