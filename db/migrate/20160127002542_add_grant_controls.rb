class AddGrantControls < ActiveRecord::Migration
  def change
    change_table :grants do |t|
      t.string :status
      t.float :grant_amount
      t.string :check_number
      t.string :payee
    end
  end
end
