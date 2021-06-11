class RelationshipsController < ApplicationController

   before_action :set_user, except: [:follow, :unfollow]
  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end


  def follows
    @followings = @user.following_user

  end

  def followers
    @followers = @user.follower_user
  end



  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
