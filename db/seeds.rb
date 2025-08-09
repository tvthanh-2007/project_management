# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
