class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :feeds, dependent: :destroy
  before_validation {email.downcase}
  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: true,
                    length: {maximum: 255}, 
                    format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 6}, confirmation: true, on: :create
  validates :password, confirmation: true, on: :update
  has_secure_password
  mount_uploader :avatar, ImageUploader
end
