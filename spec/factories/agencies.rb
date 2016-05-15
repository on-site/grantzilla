FactoryGirl.define do
  factory :agency do
    name "Sample Agency"
    phone "650-555-1212"
    fax "650-555-1213"
    email "info@sample.org"
    address "123 Main St."
    city "Palo Alto"
    state "CA"
    zip "94305"

    trait :admin do
      name "HIF"
    end
  end
end
