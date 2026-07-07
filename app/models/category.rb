class Category < ApplicationRecord
  validates :name,
            presence: true,
            length: {
              minimum: 3,
              maximum: 25
            },
            uniqueness: {
              case_sensitive: false
            }

  has_many :articles_categories
  has_many :articles, through: :articles_categories
end
