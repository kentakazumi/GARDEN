class PostImageTagRelation < ApplicationRecord
  belongs_to :post_image
  belongs_to :tag

private
  def check_for_tag_name_validator
    self.errors.add(:tag_name, "cant be blank")if self.tag_name_validator == true
  end
end
