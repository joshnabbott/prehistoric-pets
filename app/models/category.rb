class Category < ActiveRecord::Base
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :parent_id
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_nil => true
end
