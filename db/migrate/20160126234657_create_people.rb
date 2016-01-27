class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :grant_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :birth_date
      t.boolean :veteran
      t.boolean :student
      t.boolean :full_time_student
    end
    add_foreign_key :people, :grants
  end
end
