class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 0, member: 1 }

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
end
