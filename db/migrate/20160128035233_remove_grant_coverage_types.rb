class RemoveGrantCoverageTypes < ActiveRecord::Migration
  def change
    drop_table :grant_coverage_types
  end
end
