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

  after_create :create_profile

  def create_profile
    Profile.create(user_id: id)
  end
end
