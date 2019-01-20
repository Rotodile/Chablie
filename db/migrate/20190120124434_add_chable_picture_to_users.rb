class AddChablePictureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :chable_picture, :string
  end
end
