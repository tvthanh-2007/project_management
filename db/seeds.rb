puts "Create Admin"
User.create(name: "Admin", username: "admin", password: "Aa123456", password_confirmation: "Aa123456", role: :admin)

puts "Create Users"
Array(1..5).each do |index|
  FactoryBot.create(:user, email: "tvthanh200782+#{index}@gmail.com")
end

puts "Create Projects"
FactoryBot.create(:project, name: "project admin", user: User.admin.first)

Array(1..5).each do |index|
  FactoryBot.create(:project, name: "project #{index}", user: User.member.first)
end
