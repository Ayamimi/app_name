class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :bats, dependent: :destroy
    has_many :bated_users, through: :bats, source: :user

    has_many :outs, dependent: :destroy
    has_many :outed_users, through: :outs, source: :user

    mount_uploader :video, VideoUploader
    mount_uploader :image1, ImageUploader
    mount_uploader :image2, ImageUploader
    mount_uploader :image3, ImageUploader
    mount_uploader :image4, ImageUploader
    mount_uploader :image5, ImageUploader
    has_many :post_tag_relations, dependent: :destroy
    has_many :tags, through: :post_tag_relations, dependent: :destroy

    def save_tag(tag_list)
        current_tags = self.tags.pluck(:name) unless self.tags.nil?
        old_tags = current_tags - tag_list
        new_tags = tag_list - current_tags
        # Destroy old taggings:
        old_tags.each do |old_name|
            self.tags.delete Tag.find_by(name: old_name)
        end
        # Create new taggings:
        new_tags.each do |new_name|
            post_tag = Tag.find_or_create_by(name: new_name)
            self.tags << post_tag
        end
    end
end
