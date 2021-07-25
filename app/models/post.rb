class Post < ApplicationRecord
  include Voteable
  include Sluggable

  default_scope { order('created_at DESC') }

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  validates_presence_of :title, :url, :description
  validates :title, length: { minimum: 5 }
  validates :url, uniqueness: true

  sluggable_column :title
end
