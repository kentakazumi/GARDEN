class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
   has_many :post_images, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
   has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
   has_many :following_user, through: :follower, source: :followed
   has_many :follower_user, through: :followed, source: :follower
   has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
   has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def follow(followed)
    follower.create(followed_id: followed.id)
     #通知の作成
     create_notification_follow(self, followed)
  end


  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def create_notification_follow(follower, followed)
        notification = follower.active_notifications.new(
          visited_id: followed.id,
          action: "follow"
        )
        notification.save if notification.valid?
  end

end
