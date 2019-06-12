class Tag < ApplicationRecord
    has_many :chable_tags
    has_many :chables, through: :chable_tags
    has_many :comment_tags
    has_many :comments, through: :comment_tags
end
