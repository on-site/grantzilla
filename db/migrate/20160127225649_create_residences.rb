class CreateResidences < ActiveRecord::Migration
  def change
    create_table :residence_types do |t|
      t.string :description
    end

    create_table :residences do |t|
      t.string :address
      t.string :unit_number
      t.string :city
      t.string :state
      t.string :zip
      t.integer :residence_type_id
      t.date :move_in_date
      t.date :move_out_date
      t.string :reason_left
      t.boolean :transitional_housing
      t.float :rent
      t.float :deposit
      t.float :amount_returned
    end

    add_foreign_key :residences, :residence_types

    add_column :grants, :residence_id, :integer
    add_column :grants, :previous_residence_id, :integer

    add_foreign_key :grants, :residences, column: :residence_id
    add_foreign_key :grants, :residences, column: :previous_residence_id
  end
end
