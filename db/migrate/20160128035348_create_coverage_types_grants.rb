class CreateCoverageTypesGrants < ActiveRecord::Migration
  def change
    create_table :coverage_types_grants do |t|
      t.references :coverage_type, index: true, foreign_key: true
      t.references :grant, index: true, foreign_key: true
    end
  end
end
