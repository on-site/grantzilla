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

unless Rails.env.production?
  agency = Agency.create!({name: "HIF"})
  user = User.new
  user.email = "admin@hifinf.org"
  user.password = "password"
  user.role = "case_worker"
  user.agency = agency
  user.skip_confirmation!
  user.save!
end

user = User.new
user.email = "admin@hifinfo.org"
user.password = "password"
user.role = "admin"
user.approved = true
user.skip_confirmation!
user.save!
