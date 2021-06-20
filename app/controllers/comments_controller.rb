class CommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @comment = Comment.new(comment_params)
    @comment.post_image_id = @post_image.id
    @comment.user_id = current_user.id
    if @comment.save
       commented = User.find(PostImage.find(@comment.post_image_id).user_id)
       @comment.create_notification_comment(current_user, commented, @comment.post_image_id)
       render :index
    end
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

    private
    def comment_params
      params.require(:comment).permit(:comment, :post_image_id, :user_id)
    end


end
