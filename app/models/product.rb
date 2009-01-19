class Product < ActiveRecord::Base
  include Prehistoric
  acts_as_fleximage :image_directory => 'public/images/uploads'
  before_validation :create_permalink
  belongs_to :caresheet
  belongs_to :category
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :name, :sku, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }
end