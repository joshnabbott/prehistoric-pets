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

  def path(column = 'permalink')
    ancestors.reverse.push(self).map(&:"#{column.to_s}").join('/')
  end

  def self.update_positions(*positions)
    # positions is an array of Category ids. => ['1','2','3']
    # it can be passed in either way:
    # Category.update_positions(['1','2','3'])
    # Category.update_positions(1,2,3)
    # Just use Array#flatten to turn this: [['1','2','3']] (when an array is passed in)
    # to this: ['1','2','3']
    positions = positions.flatten
    # Removes blank items from array (jQuery is passing back an empty value for one array item)
    positions.delete_if { |item| item.blank? }
    positions.each_with_index do |id, index|
      position = index + 1
      self.update(id, :position => position)
    end
  end
end
