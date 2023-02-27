class AddImage3ToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :image3, :string
  end
end
