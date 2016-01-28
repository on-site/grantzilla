class AddIncomeType < ActiveRecord::Migration
  def change
    create_table :income_types do |t|
      t.string :description
    end

    add_column :incomes, :income_type_id, :integer

    add_foreign_key :incomes, :income_types
  end
end
