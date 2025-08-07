class MemberProject < ApplicationRecord
  enum :role, { manager: 0, write: 1, read: 2 }
end
