class AddFundingDateToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :funding_date, :datetime
  end
end
