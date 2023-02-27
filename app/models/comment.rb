class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :outs, dependent: :destroy
  has_many :outed_users, through: :outs, source: :user

end
