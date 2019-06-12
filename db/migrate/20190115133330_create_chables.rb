class CreateChables < ActiveRecord::Migration[5.2]
  def change
    create_table :chables do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :chables, [:user_id, :created_at]
  end
end
