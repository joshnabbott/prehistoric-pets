# == Schema Information
# Schema version: 20090302034918
#
# Table name: categories
#
#  id                  :integer(4)      not null, primary key
#  parent_id           :integer(4)
#  name                :string(255)
#  permalink           :string(255)
#  description         :text
#  is_active           :boolean(1)      not null
#  is_price_specific   :boolean(1)      not null
#  starting_price      :decimal(8, 2)   default(0.0)
#  ending_price        :decimal(8, 2)   default(0.0)
#  position            :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#  old_category_id     :integer(4)
#  old_sub_category_id :integer(4)
#

class Category < ActiveRecord::Base
  include Prehistoric
  default_scope :order => 'position asc'
  acts_as_list :scope => :parent_id
  acts_as_tree :order => :parent_id
  before_validation :create_permalink
  has_many :products, :through => :taxons
  has_many :taxons, :dependent => :destroy
  validates_presence_of :name, :permalink
  validates_uniqueness_of :name, :permalink, :scope => :parent_id, :allow_nil => true
  named_scope :roots, :conditions => { :parent_id => nil }

  def path
    ancestors.reverse.push(self).map(&:permalink).join('/')
  end
end
