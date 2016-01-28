class AddLookupValues < ActiveRecord::Migration
  VALUES = {
    IncomeType => %w{
      Employment
      SSI/SSDI
      EDD
      None
      Permanently Disabled
      Temporarily Disabled
    },
    ResidenceType => %w{
      Room
      Apartment
      Single family home
      Town home
    },
    SubsidyType => %w{
      Housing 1000
      Section 8 voucher
      HUD-VASH
    },
    ReasonType => %w{
      Injury
      Illness
      Death in the family
      Natural disaster
      Currently homeless
      Moving from unsuitable living conditions
      Victim of crime
      Temporary loss of employment
      Rent increase unaffordable
      No-fault notice to vacate
      Unanticipated expenses
      Moving from shelter
      Delay/cancellation of assistance or benefits
      Other
    }
  }

  def up
    VALUES.each do |klass, descriptions|
      descriptions.each do |desc|
        klass.create(description: desc)
      end
    end
  end

  def down
    VALUES.each do |klass, descriptions|
      klass.where(description: descriptions).delete_all
    end
  end
end
