class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  validates_presence_of :title, :url, :description
  validates :title, length: { minimum: 5 }
  validates :url, uniqueness: true

  before_save :generate_slug

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

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
  end
end
