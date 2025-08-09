class Project < ApplicationRecord
  belongs_to :user
  has_many :invitations
  has_many :member_prejects, dependent: :destroy
  has_many :users, through: :member_prejects

  enum :visibility, { public: 0, private: 1 }, prefix: true

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
