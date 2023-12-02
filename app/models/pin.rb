class Pin < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :poly_comments, as: :commentable, dependent: :destroy

  belongs_to :user
  mount_uploader :pin_image, PinImageUploader

  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  def api_as_json
    {
      title: title,
      description: description,
      pin_image: 'http://localhost:3000' + pin_image.url
    }
  end
end
