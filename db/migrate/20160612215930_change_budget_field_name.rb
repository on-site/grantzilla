class ChangeBudgetFieldName < ActiveRecord::Migration
  def change
    change_table :budgets do |t|
      t.rename :installment_payment_description, :installment_payments_description
    end
  end
end
