class MemberProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :role, { manager: 0, write: 1, read: 2 }
end
