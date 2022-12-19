require "rails_helper"

describe "/roles" do
  let(:valid_params) {
    { user: user.attributes.merge(roles_attributes: attributes_for(:role, id: nil)) }
  }

  let(:invalid_params) {
    { user: user.attributes.merge(roles_attributes: attributes_for(:role, name: nil, id: nil)) }
  }

  let(:user) { create(:user) }

  describe "GET /show" do
    it "returns a successful response" do
      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) {
        { user: user.attributes.merge(roles_attributes: attributes_for(:role, id: nil)) }
      }

      it "updates the requested record" do
        patch user_path(user), params: new_params
        user.roles.first.reload
        expect(user.roles.first.name).to eq(new_params.dig(:user, :roles_attributes)[:name])
      end

      it "returns a successful status" do
        patch user_path(user), params: new_params
        user.roles.first.reload
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "does not updates the record" do
        patch user_path(user), params: valid_params
        patch user_path(user), params: invalid_params
        user.roles.first.reload
        expect(user.roles.first.name).not_to eq(invalid_params[:name])
      end

      it "returns an error response status" do
        patch user_path(user), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
