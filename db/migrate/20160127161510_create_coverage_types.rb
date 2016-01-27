class CreateCoverageTypes < ActiveRecord::Migration
  def change
    create_table :coverage_types do |t|
      t.string :description
    end

    create_table :grant_coverage_types do |t|
      t.integer :grant_id
      t.integer :coverage_type_id
      t.boolean :past_due
    end

    add_foreign_key :grant_coverage_types, :grants
    add_foreign_key :grant_coverage_types, :coverage_types
  end
end
