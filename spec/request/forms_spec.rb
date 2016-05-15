require 'rails_helper'

RSpec.describe "Forms", type: :request do
  context "when the user is logged in" do
    let(:agency) { create(:agency) }
    let(:grant) { create(:grant) }

    before do
      sign_in user
    end

    context "when the user is an admin" do
      let(:user) { create(:user, :admin) }
      it "allows the user edit a grant" do
        get "/grants/#{grant.id}/forms/applicants"
        expect(response).to have_http_status(:success)
      end
    end

    context "when the user is not an admin" do
      context "when the user is from a different agency" do
        let(:user) { create(:user, :case_worker) }
        it "gives a not found error when they attempt to edit other users" do
          get "/grants/#{grant.id}/forms/applicants"
          expect(response).to have_http_status(404)
        end
      end
      context "when the user is from the same agency" do
        let(:user) { create(:user, :case_worker, agency: grant.user.agency) }
        it "allows the user to edit a grant" do
          get "/grants/#{grant.id}/forms/applicants"
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
