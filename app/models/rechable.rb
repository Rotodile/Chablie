class Rechable < ApplicationRecord
    belongs_to :rechabler, :class_name => "user"
    belongs_to :rechable, :class_name => "chable"
end
