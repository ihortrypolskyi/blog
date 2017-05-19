# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  validates :first_name, :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 3..30 }
  has_secure_password
  validates :password_digest, presence: true, length: { in: 3..30 }, allow_nil: true
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { in: 3..30 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  before_save { email.downcase! }
  acts_as_voter
end
