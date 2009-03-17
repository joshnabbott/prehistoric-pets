# == Schema Information
# Schema version: 20090302034918
#
# Table name: caresheets
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  scientific_name  :string(255)
#  permalink        :string(255)
#  body             :text
#  is_active        :boolean(1)      not null
#  created_at       :datetime
#  updated_at       :datetime
#  old_caresheet_id :integer(4)
#

class Caresheet < ActiveRecord::Base
  include Prehistoric
  default_scope :order => 'name asc'
  before_validation :create_permalink
  has_many :products, :dependent => :nullify
  validates_presence_of :name, :body, :permalink
  validates_uniqueness_of :name, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
end
