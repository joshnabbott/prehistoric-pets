class Category < ActiveRecord::Base
  include Prehistoric
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :parent_id
  before_validation :create_permalink
  has_many :products, :dependent => :nullify
  validates_presence_of :name, :permalink
  validates_uniqueness_of :name, :permalink, :scope => :parent_id, :allow_nil => true
  named_scope :roots, :conditions => { :parent_id => nil }

  def path
    ancestors.reverse.push(self).map(&:permalink).join('/')
  end
end