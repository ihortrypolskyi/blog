class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { maximum: 500 }
  acts_as_votable
  has_ancestry

  def rule_5_minutes?
    (self.created_at + 5.minutes) > Time.new
  end
end
