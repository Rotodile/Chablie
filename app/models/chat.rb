class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
    has_many :subcriptions, dependent: :destroy
    has_many  :users, through: :subcriptions
    validates :identifier, presence: true, uniqueness: true, case_sensitive: false
end
