class Profile < ApplicationRecord
  belongs_to :user

  validates :username, uniqueness: true, on: :update
end
