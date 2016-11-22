class User < ApplicationRecord
  has_secure_password
  has_many :posts
  validates :first_name, :last_name, :uniqueness => {:case_sensitive => false}, presence: true, length: { in: 2..10 }
end
