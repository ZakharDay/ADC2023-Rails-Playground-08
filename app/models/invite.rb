class Invite < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: 'inviter_id'
  belongs_to :invitee, class_name: 'User', foreign_key: 'invitee_id', optional: true

  scope :left, -> { where(email: nil) }
end
