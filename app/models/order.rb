# == Schema Information
# Schema version: 20090302034918
#
# Table name: orders
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  ip_address       :string(255)
#  reference_number :string(255)
#  state            :string(255)     default("in_cart"), not null
#  line_items_count :integer(4)      default(0)
#  shipping         :decimal(8, 2)   default(0.0), not null
#  subtotal         :decimal(8, 2)   default(0.0), not null
#  tax              :decimal(8, 2)   default(0.0), not null
#  amount           :decimal(8, 2)   default(0.0), not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Order < ActiveRecord::Base
  include AASM
  before_create :create_reference_number
  has_many :transactions, :class_name => "OrderTransaction", :dependent => :destroy
  has_many :line_items, :dependent => :destroy

  aasm_column :state
  aasm_initial_state :shopping
  aasm_state :in_cart
  aasm_state :pending # sent to payment processor
  aasm_state :completed # returned from payment processor::completed

  aasm_event :checkout do
    transitions :to => :pending, :from => :in_cart
  end

  aasm_event :completed do
    transitions :to => :completed, :from => :pending
  end

  def add_to_cart(product, options={})
    current_product = line_items.detect { |item| item.product == product }
    if current_product
      current_product.increment_quantity
    else
      line_items.create(:product_id => product.id, :price => product.price, :quantity => options[:quantity])
    end
  end

  def product_count
    line_items.inject(0) { |sum, item| sum + item.quantity }
  end

  def subtotal
    line_items.inject(0) { |sum, item| (item.price * item.quantity) + sum }
  end

  def total
    subtotal + tax
  end

private
  def create_reference_number
    self.reference_number = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
