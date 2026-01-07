puts "Create Admin"
admin = User.find_or_create_by!(username: "admin") do |u|
  u.name = "Admin"
  u.email = "admin@example.com"
  u.password = "Aa123456"
  u.password_confirmation = "Aa123456"
  u.role = :admin
end

puts "Create Users"
users = (1..5).map do |i|
  User.find_or_create_by!(email: "tvthanh200782+#{i}@gmail.com") do |u|
    u.name = "User #{i}"
    u.username = "user#{i}"
    u.password = "Aa123456"
    u.password_confirmation = "Aa123456"
    u.role = :member
  end
end

puts "Create Projects"
Project.find_or_create_by!(
  name: "project admin",
  description: "Abc",
  user: admin
)

(1..5).map do |i|
  Project.find_or_create_by!(name: "project #{i}") do |p|
    p.user = User.member.first
    p.description = "Abcd"
  end
end

puts "Add members"
project = Project.first
users.each do |u|
  MemberProject.find_or_create_by!(user_id: u.id, project_id: project.id) do |m_p|
    m_p.role = rand(0..2)
  end
end
