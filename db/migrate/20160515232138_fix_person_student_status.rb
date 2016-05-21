class FixPersonStudentStatus < ActiveRecord::Migration
  def up
    remove_column :people, :student
    remove_column :people, :full_time_student
    add_column :people, :student_status, :string, limit: 15
  end

  def down
    remove_column :people, :student_status
    add_column :people, :student, :boolean
    add_column :people, :full_time_student, :boolean
  end
end
