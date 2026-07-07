class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {
              maximum: 105
            },
            uniqueness: {
              case_sensitive: false
            },
            format: {
              with: EMAIL_REGEX
            }
  has_many :articles, dependent: :destroy
  has_secure_password
end
