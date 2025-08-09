class Invitation < ApplicationRecord
  belongs_to :project

  enum :role, { manager: 0, write: 1, read: 2 }
  enum :status, { pending: 0, accepted: 1, expired: 2 }

  def invalid?
    expired? || (pending? && expires_at < Time.current)
  end

  def accept!
    self.update_columns(status: :accepted, accepted_at: Time.current)
  end
end
