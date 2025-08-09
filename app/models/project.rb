class Project < ApplicationRecord
  has_many :invitations
  has_many :member_prejects
  has_many :users, through: :member_prejects
end
