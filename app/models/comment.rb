class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  validates :comment, presence: true

  def create_notification_comment(commenter, commented, post_image_id)
        notification = commenter.active_notifications.new(
          post_image_id: post_image_id,
          visited_id: commented.id,
          action: "comment"
        )
        notification.save if notification.valid?
  end
end
