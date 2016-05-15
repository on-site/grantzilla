require 'rails_helper'

RSpec.describe "Users", type: :request do
  context "when the user is logged in" do
    let(:user) do
      User.create email: "test1@test.com", password: "testtest", role: role,
                  confirmed_at: Time.zone.now, approved: true
    end

    before do
      sign_in user
    end

    context "when the user is an admin" do
      let(:role) { "admin" }
      it "allows the user view the list of users" do
        get "/admin/users"
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not an admin" do
      let(:role) { "case_worker" }
      it "causes a permission denied error" do
        get "/admin/users"
        expect(response).to have_http_status(403)
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
