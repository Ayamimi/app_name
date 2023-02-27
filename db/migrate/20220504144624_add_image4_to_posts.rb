class AddImage4ToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image4, :string
  end
end
