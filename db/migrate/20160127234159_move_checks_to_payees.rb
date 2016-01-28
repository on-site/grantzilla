class MoveChecksToPayees < ActiveRecord::Migration
  def change
    remove_column :grants, :check_number, :string
    remove_column :grants, :payee, :string

    add_column :payees, :check_amount, :float
    add_column :payees, :check_date, :date
    add_column :payees, :check_number, :string
  end
end
