class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suggests, dependent: :destroy
end
