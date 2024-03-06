class Favourite < ApplicationRecord
  belongs_to :pin
  belongs_to :user
end
