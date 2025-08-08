class Token < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(deleted_at: nil) }

  validates :access_token, presence: true
  validates :refresh_token, presence: true
end
