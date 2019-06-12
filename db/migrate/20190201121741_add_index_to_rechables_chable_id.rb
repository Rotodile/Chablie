class AddIndexToRechablesChableId < ActiveRecord::Migration[5.2]
  def change
    add_index :rechables, :chable_id
  end
end
