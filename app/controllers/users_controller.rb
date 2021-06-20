class UsersController < ApplicationController
  before_action :authenticate_user!


  def new
  end

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images
    @post_image = PostImage.new
  end

  def edit
  end

  def update
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end


  private
  def user_params
    params.require(:user).permit(:name)
  end
end
