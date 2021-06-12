class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
       tag_list = tag_params[:tag_names].split(/[[:blank:]]+/).select(&:present?)
       @post_image.save_tags(tag_list)
       redirect_to post_images_path
    else
       render 'new'
    end
  end

  def index
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    @comment = Comment.new

  end


  def edit
    @post_image = PostImage.find(params[:id])
    @user = @post_image.user
    if @user != current_user
    redirect_to post_image_path
    end
  end

   def update
     @post_image = PostImage.find(params[:id])
     if @post_image.update(post_image_params)
       flash[:notice] = "You have creatad book successfully."
       redirect_to  post_image_path(@post_image.id)
     else
       @post_images = PostImage.all
       flash[:notice]= ' errors prohibited this obj from being saved:'
       render "edit"
     end
   end

   def destroy
     @post_image = PostImage.find(params[:id])
     @post_image.destroy
     redirect_to "/post_images"
   end

  private
  def post_image_params
    params.require(:post_image).permit(:title, :body, :plant_name, :image, :created_at)
  end

  def tag_params
      params.require(:post_image).permit(:tag_names)
  end

end
