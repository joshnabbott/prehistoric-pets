# == Schema Information
# Schema version: 20090302034918
#
# Table name: line_items
#
#  id         :integer(4)      not null, primary key
#  order_id   :integer(4)
#  product_id :integer(4)
#  quantity   :integer(4)      default(1), not null
#  price      :decimal(8, 2)   default(0.0), not null
#  created_at :datetime
#  updated_at :datetime
#

class LineItem < ActiveRecord::Base
  belongs_to :order, :counter_cache => :line_items_count
  belongs_to :product
  validates_presence_of :quantity, :price

  def increment_quantity
    update_attribute(:quantity, (quantity + 1))
  end

  def total
    quantity * price
  end
end
