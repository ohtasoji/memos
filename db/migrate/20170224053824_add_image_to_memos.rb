class AddImageToMemos < ActiveRecord::Migration[5.0]
  def change
    add_column :memos, :image, :string
  end
end
