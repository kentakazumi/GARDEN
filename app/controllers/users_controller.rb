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

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
