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
      assert_select "input#grant_person_first_name[name=?]", "grant[person][first_name]"
      assert_select "input#grant_person_last_name[name=?]", "grant[person][last_name]"
      assert_select "input#grant_person_birth_date[name=?]", "grant[person][birth_date]"
      assert_select "input#grant_person_email[name=?]", "grant[person][email]"
    end
  end
end
