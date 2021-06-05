class RemovePostTimeFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :post_time, :timesstamp
  end
end
