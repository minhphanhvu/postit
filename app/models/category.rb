class Category < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  before_save :generate_slug

  def to_param
    self.slug
  end
  
  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end
end
