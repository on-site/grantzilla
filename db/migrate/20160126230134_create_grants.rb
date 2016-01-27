class CreateGrants < ActiveRecord::Migration
  def change
    create_table :grants do |t|
      t.date :date
      t.string :details
    end
  end
end
