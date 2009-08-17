class ShippingCategory < ActiveRecord::Base
  default_scope :order => 'price asc'
  validates_numericality_of :price, :allow_nil => true
  validates_presence_of :name, :price
  validates_uniqueness_of :name, :allow_nil => true
  has_many :products, :dependent => :nullify
end
