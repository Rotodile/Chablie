class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable
    validates :body, presence: true, length: { maximum: 140 }
    belongs_to :user
end
