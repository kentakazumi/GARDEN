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
    if params[:tag_ids].present?
      @post_images = []
      params[:tag_ids].each do |id|
        relations = PostImageTagRelation.where(tag_id: id)
        relations.each do |relation|
          post = PostImage.find(relation.post_image_id)
          @post_images.push(post)
        end
      end
    else
      @post_images = PostImage.all
    end
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

   def search
     tag_list = params[:tag_names].split(/[[:blank:]]+/)
     tag_ids = []
     tag_list.each do |name|
       tag =  Tag.find_by(tag_name: name)
       if tag.present?
          tag_ids.push(tag.id)
       end
     end
     redirect_to post_images_path(tag_ids: tag_ids)
   end

  private
  def post_image_params
    params.require(:post_image).permit(:title, :body, :plant_name, :image, :created_at)
  end

  def tag_params
      params.require(:post_image).permit(:tag_names)
  end

end
