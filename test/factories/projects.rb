FactoryBot.define do
  factory :project do
    association :user  # user là creator

    name { Faker::App.name }
    description { Faker::Lorem.sentence }
    visibility { :private }

    after(:create) do |project|
      if project.user.member?
        # Tự động tạo member_project cho chính user creator, role manager
        create(:member_project, user: project.user, project: project, role: :manager)
      end
    end
  end
end
