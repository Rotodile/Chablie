class Comment < ApplicationRecord
    has_many :comment_tags
    has_many :tags, through: :comment_tags
    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable
    validates :body, presence: true, length: { maximum: 140 }
    belongs_to :user
    after_commit :create_tags, on: :create
  def create_tags
    extract_name_tags.each do |name|
        tags.create(name: name)
      end
  end

    def extract_name_tags
        body.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
      end
end
