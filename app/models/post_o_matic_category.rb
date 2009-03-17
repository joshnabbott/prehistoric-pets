# == Schema Information
# Schema version: 20090302034918
#
# Table name: post_o_matic_categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  url        :string(255)
#  permalink  :string(255)
#  position   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class PostOMaticCategory < ActiveRecord::Base
  include Prehistoric
  attr_accessor :time_to_post
  before_validation :create_permalink
  default_scope :order => 'name asc'
  has_many :post_o_matic_postings, :order => 'position asc', :dependent => :nullify
  validates_presence_of :name, :permalink, :url
  validates_uniqueness_of :name, :permalink, :allow_nil => true
end
