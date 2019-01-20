class AddPicturesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :picture, :string
    add_column :users, :cover_picture, :string
  end
end
