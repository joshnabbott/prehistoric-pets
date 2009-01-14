class Caresheet < ActiveRecord::Base
  include Prehistoric
  before_validation :create_permalink
  has_many :products, :dependent => :nullify
  validates_presence_of :name, :body, :permalink
  validates_uniqueness_of :name, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
end