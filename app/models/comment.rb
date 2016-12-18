class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true, length: { maximum: 200 }
  acts_as_votable
  has_ancestry
end
