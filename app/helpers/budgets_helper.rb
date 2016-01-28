module BudgetsHelper
  def budgets
    [@grant.last_month_budget,
     @grant.current_month_budget,
     @grant.next_month_budget]
  end

  def budget_income_items
    {
      earned_income1: "Applicant #1's income from employment",
      unearned_income1: "Applicant #1's unearned income<br/>SSI, SSDI, UID, CalWorks, etc.",
      earned_income2: "Applicant #2's income from employment",
      unearned_income2: "Applicant #2's unearned income<br/>SSI, SSDI, UID, CalWorks, etc.",
      household: "Other Household Members' Income (combined)",
      child_support: "Child Support/Family Support",
      food_stamps: "CalFRESH/Food Stamps",
      security_deposit_refund: "Previous Security Deposit Returned (if moving)"
    }
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

  def budget_specified_expense_items
    {
      installment_payments: "Installment payments (credit cards or loans)",
      miscellaneous_expenses: "Miscellaneous (cigarettes, entertainment, etc.)"
    }
  end
end
