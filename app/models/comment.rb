class Comment < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  validates :body, presence: true

  # Votes
  has_many :votes, as: :voteable

  def total_votes
    self.upvotes - self.downvotes
  end

  def upvotes
    self.votes.where(vote: true).size
  end

  def downvotes
    self.votes.where(vote: false).size
  end
end
