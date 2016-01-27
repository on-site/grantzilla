require "rails_helper"

RSpec.describe "Grants", type: :request do
  describe "GET /grants" do
    it "works! (now write some real specs)" do
      get grants_path
      expect(response).to have_http_status(200)
    end
  end
end
