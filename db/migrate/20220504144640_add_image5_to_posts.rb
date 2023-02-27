class AddImage5ToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image5, :string
  end
end
