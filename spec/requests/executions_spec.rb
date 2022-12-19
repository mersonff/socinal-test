# frozen_string_literal: true

require 'rails_helper'

describe '/executions' do
  let(:execution) { create(:execution) }
  let(:task) { execution.task }
  let(:user_id) { execution.user.id }

  let(:valid_params) do
    {
      user_id: user_id
    }
  end

  let(:invalid_params) do
    {
      user_id: 0
    }
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get task_executions_path(task)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get task_execution_path(task, execution)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new record' do
        expect do
          post task_executions_path(task), params: { execution: valid_params }
        end.to change(task.executions, :count).by(1)
      end

      it 'returns a successful response status' do
        post task_executions_path(task), params: { execution: valid_params }
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new record' do
        expect do
          post task_executions_path(task), params: { execution: invalid_params }
        end.not_to change(task.executions, :count)
      end

      it 'returns an error response status' do
        post task_executions_path(task), params: { execution: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before do
        execution.user.roles.each { |x| x.update(name: 'execution.update') }
      end

      let(:new_params) do
        user = create(:user)
        user.roles << task.role
        { user_id: user.id }
      end

      it 'updates the requested record' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: new_params }
        execution.reload
        expect(execution.user_id).to eq(new_params[:user_id])
      end

      it 'returns a successful status' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: new_params }
        execution.reload
        expect(response).to be_successful
      end
    end

    context 'with invalid parameters' do
      it 'does not updates the record' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: invalid_params }
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it 'returns an error response status' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid role' do
      before do
        execution.user.roles.update!(name: 'invalid.role')
      end

      it 'does not updates the record' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: valid_params }
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it 'returns an error response status' do
        patch task_execution_path(task, execution, user_id: user_id), params: { execution: valid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with valid role' do
      it 'removes the requested record' do
        execution.user.roles.each { |x| x.update(name: 'execution.destroy') }

        expect do
          delete task_execution_path(task, execution, user_id: user_id)
        end.to change(task.executions, :count).by(-1)
      end
    end

    context 'with invalid role' do
      it "doesn't remove the requested record" do
        execution.user.roles.each { |x| x.update(name: 'invalid.role') }

        expect do
          delete task_execution_path(task, execution, user_id: user_id)
        end.not_to change(task.executions, :count)
      end
    end
  end
end
