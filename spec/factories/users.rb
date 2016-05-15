FactoryGirl.define do
  factory :user do
    approved true
    confirmed_at { Time.zone.now }
    sequence(:email) { |n| "#{first_name}#{n}@example.com" }
    first_name "John"
    last_name  "Doe"
    password "password"
    role "case_worker"
    association :agency

    trait :admin do
      role "admin"
      association :agency, factory: [:agency, :admin]
    end

    trait :case_worker do
      role "case_worker"
    end

    trait :unapproved do
      approved false
    end

    trait :unconfirmed do
      confirmed_at nil
    end
  end
end
