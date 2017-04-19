class Product < ActiveRecord::Base
  validates :name, :description, :count, :price, presence: true
  has_many :orders, through: order_products
end
