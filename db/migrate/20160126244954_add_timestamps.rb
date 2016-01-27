class AddTimestamps < ActiveRecord::Migration
  def change
    add_column :grants, :created_at, :datetime
    add_column :grants, :updated_at, :datetime
    add_column :people, :created_at, :datetime
    add_column :people, :updated_at, :datetime
    add_column :reason_types, :created_at, :datetime
    add_column :reason_types, :updated_at, :datetime
    add_column :grant_reasons, :created_at, :datetime
    add_column :grant_reasons, :updated_at, :datetime
    add_column :incomes, :created_at, :datetime
    add_column :incomes, :updated_at, :datetime
  end
end
