class AddPropertyInfoToGrant < ActiveRecord::Migration
  def add_grants(column, type = :string)
    add_column :grants, column, :string
  end

  def change
    add_grants :ehf_number

    # Applicant's address
    add_grants :street_address
    add_grants :unit_number
    add_grants :city
    add_grants :state
    add_grants :zip
    add_grants :move_in_date, :date

    # Rent information
    add_grants :total_rent, :float
    add_grants :adjusted_rent, :float
    add_grants :subsidized, :boolean
    add_grants :subsidy_type_id, :integer

    # Financial Needs
    add_grants :months_owed, :integer
    add_grants :rent_owed, :float
    add_grants :security_deposit_owed, :float
    add_grants :utility_type_owed, :string
    add_grants :utility_owed, :float
  end
end
