class AddGrantRemainingAmountComment < ActiveRecord::Migration[5.0]
  def change
    add_column :grants, :remaining_amount_comment, :text
  end
end
