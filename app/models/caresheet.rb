class Caresheet < ActiveRecord::Base
  before_validation :create_permalink
  has_many :products, :dependent => :nullify
  validates_presence_of :name, :body, :permalink
  validates_uniqueness_of :name, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
private
  def create_permalink
    self.permalink = self.name.to_permalink unless self.permalink
  end
end