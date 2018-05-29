class Product < ApplicationRecord
  belongs_to :category
  has_many :product_pictures, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
end
