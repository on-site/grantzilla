class AddDemographicToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :ethnicity, :string, limit: 50
    add_column :people, :household_income, :string, limit: 50
    add_column :people, :age_group, :string, limit: 50
    add_column :people, :education_level, :string, limit: 50
    add_column :people, :gender, :string, limit: 50
    add_column :people, :disability, :string, limit: 50
  end
end
