class CreateChableTags < ActiveRecord::Migration[5.2]
  def change
    create_table :chable_tags do |t|
      t.belongs_to :chable, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
