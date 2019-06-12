class CommentTag < ApplicationRecord
    belongs_to :comment
    belongs_to :tag
end
