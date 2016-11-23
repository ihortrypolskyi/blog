class User < ApplicationRecord
      has_many :posts
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :first_name, :last_name, :uniqueness => {:case_sensitive => false}, presence: true, length: { in: 2..20 }
  validates :last_name, :uniqueness => {:case_sensitive => false}, presence: true, length: { in: 2..20 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
