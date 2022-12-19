# frozen_string_literal: true

class ExecutionsController < ApplicationController
  before_action :set_task
  before_action :set_execution, only: %i[show update destroy]
  before_action :set_user, only: %i[update destroy]

  def index
    @executions = @task.executions.all
  end

  def show
    render @execution
  end

  def create
    execution = @task.executions.new(execution_params)

    if execution.save
      render json: execution, status: :created
    else
      render json: execution.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @execution.try_update(@user, execution_params)
      render json: @execution
    else
      render json: @execution.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @execution.try_destroy(@user)
      head :no_content
    else
      render json: @execution.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_execution
    @execution = @task.executions.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def execution_params
    params.require(:execution).permit(:user_id)
  end
end
