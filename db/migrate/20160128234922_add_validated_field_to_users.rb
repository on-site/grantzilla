class AddValidatedFieldToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :validated, null: false, default: 0
    end
  end
end
