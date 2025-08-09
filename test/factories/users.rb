FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Internet.username(specifier: 5..8) }
    password { "Aa123456" }
    password_confirmation { "Aa123456" }
    role { :member }
  end
end
