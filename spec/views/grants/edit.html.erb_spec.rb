require 'rails_helper'

RSpec.describe "grants/edit", type: :view do
  before(:each) do
    @grant = assign(:grant, Grant.create!(
      :details => "MyString"
    ))
  end

  it "renders the edit grant form" do
    render

    assert_select "form[action=?][method=?]", grant_path(@grant), "post" do

      assert_select "input#grant_details[name=?]", "grant[details]"
    end
  end
end
