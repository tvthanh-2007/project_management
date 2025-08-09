FactoryBot.define do
  factory :invitation do
    association :project
    email { Faker::Internet.email }
    role { :read }
    status { :pending }
    token { SecureRandom.hex(20) }
    expires_at { 7.days.from_now }
    accepted_at { nil }

    trait :accepted do
      status { :accepted }
      accepted_at { Time.current }
    end

    trait :expired do
      status { :expired }
      expires_at { 1.day.ago }
    end
  end
end
