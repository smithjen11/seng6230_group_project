class OrderProduct < ActiveRecord::Base
  validates :order_id, :product_id, :product_count, presence: true
end
