class CreateOtherPayments < ActiveRecord::Migration
  def change
    create_table :other_payments do |t|
      t.integer :grant_id
      t.float :amount
      t.date :date_paid
      t.string :description
    end

    add_foreign_key :other_payments, :grants
  end
end
