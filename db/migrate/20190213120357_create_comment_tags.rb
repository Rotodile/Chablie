class CreateCommentTags < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_tags do |t|
      t.belongs_to :comment, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
