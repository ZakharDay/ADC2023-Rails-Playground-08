class Comment < ApplicationRecord
  has_many :replies, class_name: "Comment", foreign_key: "reply_to_comment_id", dependent: :destroy
  belongs_to :comment, class_name: "Comment", foreign_key: "reply_to_comment_id", optional: true

  belongs_to :pin
  belongs_to :user

  default_scope { where(reply_to_comment_id: nil) }

  after_create_commit { broadcast_append_to("comments") }
  after_update_commit { broadcast_replace_to("comment") }
end
