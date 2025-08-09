FactoryBot.define do
  factory :member_project do
    association :user
    association :project
    role { :read }
  end
end
