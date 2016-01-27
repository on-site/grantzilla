require "rails_helper"

RSpec.describe "grants/new", type: :view do
  before(:each) do
    grant = Grant.new
    grant.people.build
    assign(:grant, grant)
  end

  it "renders new grant form" do
    render

    assert_select "form[action=?][method=?]", grants_path, "post" do
      assert_select "input#grant_people_attributes_0_first_name[name=?]", "grant[people_attributes][0][first_name]"
      assert_select "input#grant_people_attributes_0_last_name[name=?]", "grant[people_attributes][0][last_name]"
      assert_select "input#grant_people_attributes_0_birth_date[name=?]", "grant[people_attributes][0][birth_date]"
      assert_select "input#grant_people_attributes_0_email[name=?]", "grant[people_attributes][0][email]"
    end
  end
end
