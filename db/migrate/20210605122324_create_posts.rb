class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :plant_name
      t.text :body
      t.integer :user_id
      t.integer :image_id

    end
  end
end
