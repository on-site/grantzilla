class AddDependentDetails < ActiveRecord::Migration[5.0]
  def up
    add_column :people, :person_type, :string, limit: 20
    change_column :people, :student_status, :string, limit: 20
  end

  def down
    remove_column :people, :person_type
    change_column :people, :student_status, :string, limit: 15
  end
end
