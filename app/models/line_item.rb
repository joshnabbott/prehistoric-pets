class LineItem < ActiveRecord::Base
  belongs_to :order, :counter_cache => :line_items_count
  belongs_to :product
  validates_presence_of :quantity, :price

  def increment_quantity
    update_attribute(:quantity, (quantity + 1))
  end
end
