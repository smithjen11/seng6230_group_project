class Order < ActiveRecord::Base
  validates :payment_total, :payment_type, :employee, presence: true
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end
