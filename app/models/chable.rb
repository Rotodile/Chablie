class Chable < ApplicationRecord
  attr_accessor :content, :chable_picture
  mount_uploader :chable_picture, ChablePictureUploader
  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :chable_picture_size

  private

  def chable_picture_size
    if chable_picture.size > 5.megabytes
      error.add(:picture, "should be less than 5mb")
    end
  end
end
