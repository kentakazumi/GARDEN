class SearchController < ApplicationController
  def search
    tag = Tag.where(tag_name: params[:tag_name])
    @post_images = tag.post_images
  end

  def tag_params
      params.require(:tag).permit(:tag_names)
  end
end
