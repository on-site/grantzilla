class ResetGrantId < ActiveRecord::Migration
  def self.up
    execute "ALTER SEQUENCE grants_id_seq RESTART WITH 10000"
  end

  def self.down
  end
end
