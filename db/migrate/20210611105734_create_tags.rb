class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      # NULL での保存を DB レベルで制限
      t.string :tag_name, null: false

      t.timestamps

      # tag_name で検索するため index を貼り 一意制約を設定
      t.index :tag_name, unique: true
    end
  end
end
