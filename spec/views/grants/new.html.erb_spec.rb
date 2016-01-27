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
      assert_select "input#grant_person_first_name[name=?]", "grant[person][first_name]"
      assert_select "input#grant_person_last_name[name=?]", "grant[person][last_name]"
      assert_select "input#grant_person_birth_date[name=?]", "grant[person][birth_date]"
      assert_select "input#grant_person_email[name=?]", "grant[person][email]"
    end
  end
end
