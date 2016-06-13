module BudgetsHelper
  def budget_types
    [:last_month_budget,
     :current_month_budget,
     :next_month_budget]
  end

  # rubocop:disable Metrics/MethodLength
  def budget_expense_items
    {
      rent: "Rent",
      utilities: "Utilities PG&E/water/garbage",
      phone: "Telephone",
      food: "Food",
      health_insurance: "Health Insurance",
      medical: "Medical Expenses (Rx, co-pays, etc.)",
      auto_loan: "Car Payment",
      auto_insurance: "Auto Insurance",
      auto_expenses: "Gas/Tolls/Parking",
      public_transportation: "Public Transportation",
      child_care: "Child Care",
      clothing: "Clothing",
      toiletries: "Toiletries",
      household: "Laundry, cleaning, other household items",
      television: "Television",
      internet: "Internet"
    }
  end

  def budget_income_items
    items = {
      earned_income1: "Applicant #1's income from employment",
      unearned_income1: "Applicant #1's unearned income<br/>SSI, SSDI, UID, CalWorks, etc."
    }
    items.merge!(second_applicant_income_types) if @grant.people.size > 1
    items.merge!(extra_applicant_income_types) if @grant.people.size > 2
    items.merge(
      child_support: "Child Support/Family Support",
      food_stamps: "CalFRESH/Food Stamps",
      security_deposit_refund: "Previous Security Deposit Returned (if moving)"
    )
  end

  def budget_specified_expense_items
    {
      installment_payments: "Installment payments (credit cards or loans)",
      miscellaneous_expenses: "Miscellaneous (cigarettes, entertainment, etc.)"
    }
  end

  def append_description(field)
    "#{field}_description".to_sym
  end

  private

  def second_applicant_income_types
    {
      earned_income2: "Applicant #2's income from employment",
      unearned_income2: "Applicant #2's unearned income<br/>SSI, SSDI, UID, CalWorks, etc."
    }
  end

  def extra_applicant_income_types
    { other_household_income: "Other Household Members' Income (combined)" }
  end
end
