class CreatePayee < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.integer :grant_id
      t.string :name
      t.string :attention
      t.string :street_address
      t.string :unit_number
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone
    end
  end
end
