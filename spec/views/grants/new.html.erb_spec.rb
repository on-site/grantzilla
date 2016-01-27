require "rails_helper"

RSpec.describe "grants/new", type: :view do
  before(:each) do
    assign(:grant, Grant.new(
                     details: "MyString"
    ))
  end

  it "renders new grant form" do
    render

    assert_select "form[action=?][method=?]", grants_path, "post" do
      assert_select "input#grant_details[name=?]", "grant[details]"
    end
  end
end
