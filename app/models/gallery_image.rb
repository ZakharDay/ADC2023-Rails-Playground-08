class GalleryImage < ApplicationRecord
  belongs_to :gallery
  acts_as_list scope: :gallery
  mount_uploader :image, GalleryImageUploader
end
