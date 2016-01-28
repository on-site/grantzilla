class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.float :earned_income1
      t.float :unearned_income1
      t.float :earned_income2
      t.float :unearned_income2
      t.float :other_household_income
      t.float :child_support
      t.float :food_stamps
      t.float :security_deposit_refund
      t.float :rent
      t.float :utilities
      t.float :phone
      t.float :food
      t.float :health_insurance
      t.float :medical
      t.float :auto_loan
      t.float :auto_insurance
      t.float :auto_expenses
      t.float :public_transportation
      t.float :child_care
      t.float :clothing
      t.float :toiletries
      t.float :household
      t.float :television
      t.float :internet
      t.float :installment_payments
      t.string :installment_payment_description
      t.float :miscellaneous_expenses
      t.string :miscellaneous_expenses_description

      t.timestamps null: false
    end

    add_column :grants, :last_month_budget_id, :integer
    add_column :grants, :current_month_budget_id, :integer
    add_column :grants, :next_month_budget_id, :integer
    add_foreign_key :grants, :budgets, column: :last_month_budget_id
    add_foreign_key :grants, :budgets, column: :current_month_budget_id
    add_foreign_key :grants, :budgets, column: :next_month_budget_id
  end
end
