class CreatePostImageTagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :post_image_tag_relations do |t|
      t.references :post_image, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
