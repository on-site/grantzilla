class RemoveGrantReasons < ActiveRecord::Migration
  def change
    drop_table :grant_reasons
  end
end
