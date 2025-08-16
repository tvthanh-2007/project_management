puts "Create Admin"
User.create(name: "Admin", username: "admin", password: "Aa123456", password_confirmation: "Aa123456", role: :admin)

puts "Create Users"
Array(1..5).each do |index|
  FactoryBot.create(:user, email: "tvthanh200782+#{index}@gmail.com", username: "member#{index}")
end

puts "Create Projects"
puts "Add members"
project_admin = FactoryBot.create(:project, name: "project admin", user: User.admin.first)

User.member.each do |user|
  FactoryBot.create(:member_project, user: user, project: project_admin, role: rand(0..2))
end

manager = User.member.first
members = User.member.where.not(id: manager.id)

Array(1..5).each do |index|
  project_member = FactoryBot.create(:project, name: "project #{index}", user: manager)

  members.each do |user|
    FactoryBot.create(:member_project, user: user, project: project_member, role: rand(0..2))
  end
end
