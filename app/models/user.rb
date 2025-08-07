class User < ApplicationRecord
  enum role: { admin: 0, member: 1 }
end
