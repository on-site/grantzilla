QUALIFYING_CRITERIA = [
  "Injury/Illness/Death in Family",
  "Loss of employment",
  "Moving from temporary/unsuitable living conditions",
  "Currently honeless",
  "Rent increase unaffordable",
  "Victim of crime/natural disaster",
  "Delay/cancellation/change in subsidy, assistance, or benefits",
  "No-fault notice to vacate",
  "Unanticipated expenses"
]

QUALIFYING_CRITERIA.each do |criteria|
  ReasonType.create(description: criteria)
end

