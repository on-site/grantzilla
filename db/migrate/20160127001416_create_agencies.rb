class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
