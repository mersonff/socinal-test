require "rails_helper"

describe "/executions" do
  let(:execution) { create(:execution) }
  let(:task) { execution.task }
  let(:user_id) { execution.user.id }

  let(:valid_params) {
    {
      user_id:
    }
  }

  let(:invalid_params) {
    {
      user_id: 0
    }
  }

  describe "GET /index" do
    it "returns a successful response" do
      get task_executions_path(task)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get task_execution_path(task, execution)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new record" do
        expect {
          post task_executions_path(task), params: { execution: valid_params }
        }.to change(task.executions, :count).by(1)
      end

      it "returns a successful response status" do
        post task_executions_path(task), params: { execution: valid_params }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not create a new record" do
        expect {
          post task_executions_path(task), params: { execution: invalid_params }
        }.not_to change(task.executions, :count)
      end

      it "returns an error response status" do
        post task_executions_path(task), params: { execution: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      before {
        execution.user.roles.update_all(name: "execution.update")
      }

      let(:new_params) do
        user = create(:user)
        user.roles << task.role
        { user_id: user.id }
      end

      it "updates the requested record" do
        patch task_execution_path(task, execution, user_id:), params: { execution: new_params }
        execution.reload
        expect(execution.user_id).to eq(new_params[:user_id])
      end

      it "returns a successful status" do
        patch task_execution_path(task, execution, user_id:), params: { execution: new_params }
        execution.reload
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        patch task_execution_path(task, execution, user_id:), params: { execution: invalid_params }
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it "returns an error response status" do
        patch task_execution_path(task, execution, user_id:), params: { execution: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid role" do
      before {
        execution.user.roles.update!(name: "invalid.role")
      }

      it "does not updates the record" do
        patch task_execution_path(task, execution, user_id:), params: { execution: valid_params }
        execution.reload
        expect(execution.user_id).not_to eq(invalid_params[:user_id])
      end

      it "returns an error response status" do
        patch task_execution_path(task, execution, user_id:), params: { execution: valid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    context "with valid role" do
      it "removes the requested record" do
        execution.user.roles.update_all(name: "execution.destroy")

        expect {
          delete task_execution_path(task, execution, user_id:)
        }.to change(task.executions, :count).by(-1)
      end
    end

    context "with invalid role" do
      it "doesn't remove the requested record" do
        execution.user.roles.update_all(name: "invalid.role")

        expect {
          delete task_execution_path(task, execution, user_id:)
        }.not_to change(task.executions, :count)
      end
    end
  end
end
