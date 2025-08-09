class User < ApplicationRecord
  has_secure_password

  has_many :member_projects
  has_many :projects, through: :member_projects

  enum :role, { admin: 0, member: 1 }

  validates :email, uniqueness: true, if: :member?

  class << self
    def generate_tokens(user)
      payload = { user_id: user.id, exp: 1.hour.from_now.to_i }
      access_token = JsonWebToken.encode(payload)

      refresh_payload = { user_id: user.id, exp: 1.days.from_now.to_i }
      refresh_token = JsonWebToken.encode(refresh_payload)

      {
        access_token:,
        refresh_token:
      }
    end
  end

  def only_read?(project_id)
    member? && member_prejects.where(project_id:).read?
  end

  def has_owner?(project)
    project.user_id == id
  end
end
