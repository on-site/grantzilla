class AddAgencyRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :agency, index: true, foreign_key: true
  end
end
