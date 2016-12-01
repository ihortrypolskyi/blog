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
  attr_accessor :remember_token
  validates :first_name, :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..20 }
  validates :last_name, uniqueness: { case_sensitive: false }, presence: true, length: { in: 2..20 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  before_save { email.downcase! }
  #castom validation examp: validates_presence_of :body, if: lambda {|post| post.title.length > 10 }

  end
