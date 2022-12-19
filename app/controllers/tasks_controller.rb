# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  def index
    @tasks = Task.all
  end

  def show
    render @task
  end

  def create
    task = Task.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    render json: @task.errors.messages, status: :unprocessable_entity unless @task.update(task_params)
  end

  def destroy
    @task.destroy

    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :role_id)
  end
end
