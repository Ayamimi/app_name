class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false #null: falseをnameが空で保存されないように追加

      t.timestamps
    end
  end
end
