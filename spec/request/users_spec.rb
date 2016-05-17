require 'rails_helper'

RSpec.describe "Users", type: :request do
  context "when the user is logged in" do
    let(:worker) { create(:user, :case_worker) }
    before do
      sign_in user
    end

    context "when the user is an admin" do
      let(:user) { create(:user, :admin) }
      it "allows the user view the list of users" do
        get "/admin/users"
        expect(response).to have_http_status(:success)
      end
      it "allows the user to edit other users" do
        get "/admin/users/#{worker.id}/edit"
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not an admin" do
      let(:user) { create(:user, :case_worker) }
      it "gives a permission denied error when they attempt to view users" do
        get "/admin/users"
        expect(response).to have_http_status(:unauthorized)
      end
      it "gives a permission denied error when they attempt to edit other users" do
        get "/admin/users/#{worker.id}/edit"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "when a user is not logged in" do
    it "redirects them to sign in" do
      get "/admin/users"
      expect(response).to redirect_to("/users/sign_in")
    end
  end
end
