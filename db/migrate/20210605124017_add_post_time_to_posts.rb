class AddPostTimeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_time, :timestamp
  end
end
