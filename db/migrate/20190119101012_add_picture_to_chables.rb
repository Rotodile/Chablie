class AddPictureToChables < ActiveRecord::Migration[5.2]
  def change
    add_column :chables, :picture, :string
  end
end
