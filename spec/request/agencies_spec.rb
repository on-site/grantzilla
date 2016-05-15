require 'rails_helper'

RSpec.describe "Agencies", type: :request do
  context "when the user is logged in" do
    let(:agency) { create(:agency) }

    before do
      sign_in user
    end

    context "when the user is an admin" do
      let(:user) { create(:user, :admin) }
      it "allows the user view the list of agencies" do
        get "/agencies"
        expect(response).to have_http_status(:success)
      end
      it "allows the user to view/edit an agency" do
        get "/agencies/#{agency.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not an admin" do
      let(:user) { create(:user, :case_worker) }
      it "gives a permission denied error when they attempt to view agencies" do
        get "/agencies"
        expect(response).to have_http_status(403)
      end
      it "gives a permission denied error when they attempt to edit other users" do
        get "/agencies/#{agency.id}"
        expect(response).to have_http_status(403)
      end
    end
  end

  context "when a user is not logged in" do
    it "redirects them to sign in" do
      get "/agencies"
      expect(response).to redirect_to("/users/sign_in")
    end
  end
end
