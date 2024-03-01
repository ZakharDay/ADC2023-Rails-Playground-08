class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  has_many :pins
  has_many :comments
  has_one :profile
  has_many :carts, as: :cartable

  has_many :invites, class_name: 'Invite', foreign_key: 'inviter_id'
  has_one :invite, class_name: 'Invite', foreign_key: 'invitee_id'

  has_and_belongs_to_many :favourites, class_name: 'Pin', foreign_key: 'user_id'

  after_create :create_profile
  after_create :create_invites

  def create_profile
    Profile.create(user_id: id)
  end

  def create_invites
    3.times do
      Invite.create(inviter_id: id)
    end
  end

end
