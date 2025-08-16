class User < ApplicationRecord
  has_secure_password

  has_many :member_projects
  has_many :projects, through: :member_projects

  enum :role, { admin: 0, member: 1 }

  validates :email, uniqueness: true, if: :member?

  def generate_tokens
    payload = { user_id: self.id, exp: 24.hour.from_now.to_i }
    access_token = JsonWebToken.encode(payload)

    refresh_payload = { user_id: self.id, exp: 7.days.from_now.to_i }
    refresh_token = JsonWebToken.encode(refresh_payload)

    {
      access_token:,
      refresh_token:
    }
  end

  def manager_in_project?(project)
    member_projects.find_by(project_id: project.id)&.manager?
  end

  def only_read?(project_id)
    member? && member_projects.where(project_id:).read?
  end

  def has_owner?(project)
    project.user_id == id
  end
end
