class AddCountyToResidence < ActiveRecord::Migration[5.0]
  def change
    add_column :residences, :county, :string
  end
end
