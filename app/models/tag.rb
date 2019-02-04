class Tag < ApplicationRecord
    has_many :chable_tags
    has_many :chables, through: :chable_tags
end
