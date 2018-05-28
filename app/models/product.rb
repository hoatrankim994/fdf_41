class Product < ApplicationRecord
  belongs_to :category
  has_many :product_pictures, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :ratings, dependent: :destroy
  mount_uploader :picture, PictureUploader
  scope :filter_by_category, ->(category_id){where(category_id: category_id) if category_id.present?}
end
