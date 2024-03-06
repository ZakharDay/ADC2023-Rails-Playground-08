class Attachment < ApplicationRecord
  mount_uploader :file, FileUploader
  after_create_commit { broadcast_append_to('attachments') }
end
