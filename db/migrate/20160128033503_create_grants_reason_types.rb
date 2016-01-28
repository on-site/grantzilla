class CreateGrantsReasonTypes < ActiveRecord::Migration
  def change
    create_table :grants_reason_types do |t|
      t.references :grant, index: true, foreign_key: true
      t.references :reason_type, index: true, foreign_key: true
    end
  end
end
