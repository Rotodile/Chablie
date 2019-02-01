class CreateRechables < ActiveRecord::Migration[5.2]
  def change
    create_table :rechables do |t|
      t.string :content
      t.integer :user_id
      t.integer :chable_id
    end
  end
end
