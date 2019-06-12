class AddChableIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :chable_id, :integer
  end
end
