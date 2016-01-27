class CreateReasonTypes < ActiveRecord::Migration
  def change
    create_table :reason_types do |t|
      t.string :description
    end
  end
end
