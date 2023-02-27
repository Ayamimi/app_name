class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        has_many :likes, dependent: :destroy
        has_many :liked_posts, through: :likes, source: :post
        def already_liked?(post)
          self.likes.exists?(post_id: post.id)
        end 
        has_many :bats, dependent: :destroy
        has_many :bated_posts, through: :bats, source: :post
        def already_bated?(post)
          self.bats.exists?(post_id: post.id)
        end 
        has_many :outs, dependent: :destroy
        has_many :outed_comments, through: :outs, source: :comment

    has_many :comments, dependent: :destroy
    has_many :posts
    has_many :posts, dependent: :destroy #追記 ユーザーが削除されたら、ツイートも削除されるようになります。すでに書いてある場合は追記しなくて大丈夫です。
    validates :username, presence: true #追記
    validates :profile, length: { maximum: 200 } 
end
