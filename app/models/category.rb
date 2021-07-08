class Category < ApplicationRecord
  include Sluggable

  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  sluggable_column :name
end
