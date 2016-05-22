class GrantTotalAmountOwedAndRequestedAmount < ActiveRecord::Migration
  def change
    add_column :grants, :total_owed, :float
    add_column :grants, :grant_amount_requested, :float
  end
end
