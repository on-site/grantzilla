class ResetGrantId < ActiveRecord::Migration
  def self.up
    execute "ALTER SEQUENCE grants_id_seq RESTART WITH 20000"
  end

  def self.down
  end
end
