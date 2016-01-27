class CreateSubsidyTypes < ActiveRecord::Migration
  def change
    create_table :subsidy_types do |t|
      t.string :description
    end
  end
end
