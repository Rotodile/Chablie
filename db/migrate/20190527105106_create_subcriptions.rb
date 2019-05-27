class CreateSubcriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subcriptions do |t|
      t.integer :chat_id
      t.integer :user_id

      t.timestamps
    end
  end
end
