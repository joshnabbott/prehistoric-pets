class Product < ActiveRecord::Base
  include Prehistoric
  before_validation :create_permalink
  belongs_to :caresheet
  belongs_to :category
  has_many :images, :as => :owner, :dependent => :nullify
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :name, :sku, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }
end