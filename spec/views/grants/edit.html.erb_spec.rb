require "rails_helper"

RSpec.describe "grants/edit", type: :view do
  before(:each) do
    @grant = Grant.create!
    @grant.people.create!
    assign(:grant, @grant)
  end

  it "renders the edit grant form" do
    render

    assert_select "form[action=?][method=?]", grant_path(@grant), "post" do
      assert_select "input#grant_people_attributes_0_first_name[name=?]", "grant[people_attributes][0][first_name]"
      assert_select "input#grant_people_attributes_0_last_name[name=?]", "grant[people_attributes][0][last_name]"
      assert_select "input#grant_people_attributes_0_birth_date[name=?]", "grant[people_attributes][0][birth_date]"
      assert_select "input#grant_people_attributes_0_email[name=?]", "grant[people_attributes][0][email]"
    end
  end
end
