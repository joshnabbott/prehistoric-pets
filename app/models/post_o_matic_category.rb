class PostOMaticCategory < ActiveRecord::Base
  include Prehistoric
  before_validation :create_permalink
  has_many :post_o_matic_postings, :order => 'position asc', :dependent => :nullify
  validates_presence_of :name, :permalink, :url
  validates_uniqueness_of :name, :permalink, :allow_nil => true
end