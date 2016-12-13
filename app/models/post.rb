# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: {case_sensitive: false}
  validates :body, presence: true, length: { maximum: 200 }
end
