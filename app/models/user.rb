class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  # Votes
  has_many :votes

  before_save :generate_slug

  def to_param
    self.slug
  end

  def generate_slug
    self.slug = self.username.gsub(" ", "-").downcase
  end
end
