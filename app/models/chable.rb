class Chable < ApplicationRecord
  after_commit :create_tags, on: :create
  has_many :chable_tags
  has_many :tags, through: :chable_tags
  has_many :rechabler, :class_name => 'user'
  has_many :rechable
  mount_uploader :chable_picture, ChablePictureUploader
  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :chable_picture_size

  def extract_name_tags
    content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

  def create_tags
    extract_name_tags.each do |name|
      tags.create(name: name)
    end
  end

  private

  def chable_picture_size
    if chable_picture.size > 5.megabytes
      error.add(:picture, "should be less than 5mb")
    end
  end
end
