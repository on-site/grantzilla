require 'rails_helper'

RSpec.describe "grants/index", type: :view do
  before(:each) do
    assign(:grants, [
      Grant.create!(
        :details => "Details"
      ),
      Grant.create!(
        :details => "Details"
      )
    ])
  end

  it "renders a list of grants" do
    render
    assert_select "tr>td", :text => "Details".to_s, :count => 2
  end
end
