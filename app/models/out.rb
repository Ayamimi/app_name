class Out < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :comment
    
    validates_uniqueness_of :comment_id, scope: :user_id

end
