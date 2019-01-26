class AddChablePictureToChables < ActiveRecord::Migration[5.2]
  def change
    add_column :chables, :chable_picture, :string
  end
end
