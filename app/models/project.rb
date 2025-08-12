class Project < ApplicationRecord
  belongs_to :user
  has_many :invitations
  has_many :member_projects, dependent: :destroy
  has_many :users, through: :member_projects

  enum :visibility, { public: 0, private: 1 }, prefix: true

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 10 }, allow_blank: true
end
