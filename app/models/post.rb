class Post < ApplicationRecord
  has_many :poly_comments, as: :commentable, dependent: :destroy
  validates :title, presence: true

  acts_as_taggable_on :tags
  acts_as_taggable_on :categories

  has_rich_text :body
end
