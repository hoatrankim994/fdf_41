class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :suggests, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
