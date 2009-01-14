class Category < ActiveRecord::Base
  include Prehistoric
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :parent_id
  before_validation :create_permalink
  validates_presence_of :name, :permalink
  validates_uniqueness_of :name, :permalink, :scope => :parent_id, :allow_nil => true
end