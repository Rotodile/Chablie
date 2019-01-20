class User < ApplicationRecord
    has_many :chables, dependent: :destroy
    extend FriendlyId
    friendly_id :username, use: :slugged
    attr_accessor :remember_token
    mount_uploader :picture, PictureUploader
    mount_uploader :cover_picture, CoverPictureUploader
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    validates :username, presence: true, length: { maximum: 50 },
                         uniqueness: true
    validates :phone_number, presence: true, length: { maximum: 11, minimum: 11 }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validate :picture_size
    validate :cover_picture_size
    has_secure_password
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def feed
        Chable.where("user_id = ?", id)
      end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget
        update_attribute(:remember_digest, nil)
    end

    private
  
    def cover_picture_size
        if cover_picture.size > 5.megabytes
          error.add(:cover_picture, "should be less than 5mb")
        end
      end

    def picture_size
      if picture.size > 5.megabytes
        error.add(:chable_picture, "should be less than 5mb")
      end
    end
end