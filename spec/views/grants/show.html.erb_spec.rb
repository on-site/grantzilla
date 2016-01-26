require 'rails_helper'

RSpec.describe "grants/show", type: :view do
  before(:each) do
    @grant = assign(:grant, Grant.create!(
      :details => "Details"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Details/)
  end
end
