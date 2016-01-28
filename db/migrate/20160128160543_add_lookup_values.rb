class AddLookupValues < ActiveRecord::Migration
  VALUES = {
    IncomeType => [
      "Employment",
      "SSI/SSDI",
      "EDD",
      "None",
      "Permanently Disabled",
      "Temporarily Disabled"
    ],
    ResidenceType => [
      "Room",
      "Apartment",
      "Single family home",
      "Town home"
    ],
    SubsidyType => [
      "Housing 1000",
      "Section 8 voucher",
      "HUD-VASH"
    ],
    ReasonType => [
      "Injury",
      "Illness",
      "Death in the family",
      "Natural disaster",
      "Currently homeless",
      "Moving from unsuitable living conditions",
      "Victim of crime",
      "Temporary loss of employment",
      "Rent increase unaffordable",
      "No-fault notice to vacate",
      "Unanticipated expenses",
      "Moving from shelter",
      "Delay/cancellation of assistance or benefits",
      "Other"
    ],
    CoverageType => [
      "Current month's rent",
      "Past due rent (not including current month)",
      "Security Deposit (prior to move-in)",
      "Security Deposit (past-due, after move-in)",
      "Utilities"
    ]
  }

  def up
    VALUES.each do |klass, descriptions|
      klass.delete_all

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
