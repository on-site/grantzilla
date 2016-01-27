class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :person_id
      t.boolean :current
      t.date :start_date
      t.date :end_date
      t.string :employer
      t.string :occupation
      t.float :monthly_income
      t.string :reason_for_leaving
      t.boolean :disabled
      t.boolean :full_time
    end
    add_foreign_key :incomes, :people
  end
end
