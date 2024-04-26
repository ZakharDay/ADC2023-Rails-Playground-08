class Pin < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :description]

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :comments, dependent: :destroy
  has_many :poly_comments, as: :commentable, dependent: :destroy

  has_many :favourites
  has_many :users_who_favourited, through: :favourites, source: 'user'

  has_many :likes
  has_many :users_who_liked, through: :likes, source: 'user'

  belongs_to :user
  mount_uploader :pin_image, PinImageUploader

  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  def normalize_friendly_id(text)
    text.truncate(100).to_slug.transliterate(:russian).normalize.to_s
  end

  def api_as_json
    {
      title: title,
      description: description,
      pin_image: 'http://localhost:3000' + pin_image.url
    }
  end

end
