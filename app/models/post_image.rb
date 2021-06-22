class PostImage < ApplicationRecord
   belongs_to :user
   attachment :image
     has_many :favorites, dependent: :destroy
     has_many :comments, dependent: :destroy
     has_many :post_image_tag_relations, dependent: :destroy
     has_many :tags, through: :post_image_tag_relations
     has_many :notifications, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: "favorite"
        )
        notification.save if notification.valid?
  end
    def save_tags(tag_list)
      tag_list.each do |tag|
      # 受け取った値を小文字に変換して、DBを検索して存在しない場合は
      # find_tag に nil が代入され　nil となるのでタグの作成が始まる
      unless find_tag = Tag.find_by(tag_name: tag.downcase)
        begin
          # create メソッドでタグの作成
          # create! としているのは、保存が成功しても失敗してもオブジェクト
          # を返してしまうため、例外を発生させたい
          self.tags.create!(tag_name: tag)

        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else
            # DB にタグが存在した場合、中間テーブルにブログ記事とタグを紐付けている
        PostImageTagRelation.create!(post_image_id: self.id, tag_id: find_tag.id)
      end
      end
    end
end