class AddEmploymentStatusColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :employment_status, :string, limit: 25
  end
end
