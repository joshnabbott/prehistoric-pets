class Product < ActiveRecord::Base
  before_validation :create_permalink
  belongs_to :category
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :name, :sku, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }

private
  def create_permalink
    self.permalink = self.name.to_permalink unless self.permalink
  end
end