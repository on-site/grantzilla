FactoryGirl.define do
  factory :agency do
    name "Sample Agency"

    trait :admin do
      name "HIF"
    end
  end

  factory :comment do
    body "This is a test."
    association :grant
    association :user
  end

  factory :grant do
    application_date { Time.zone.now }
    status factory: :grant_status
    user
  end

  factory :grant_status do
    description "Submitted"
  end

  factory :income do
    current true
    disabled false
    monthly_income 1000

    trait :disability do
      disabled true
    end

    trait :previous do
      current false
    end
  end

  factory :person do
    first_name "Frank"
    last_name "Furter"
  end

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
