# == Schema Information
# Schema version: 20090302034918
#
# Table name: products
#
#  id              :integer(4)      not null, primary key
#  caresheet_id    :integer(4)
#  name            :string(255)
#  scientific_name :string(255)
#  permalink       :string(255)
#  sku             :string(10)      not null
#  description     :text
#  comments        :text
#  price           :decimal(8, 2)   default(0.0), not null
#  is_featured     :boolean(1)      not null
#  override        :boolean(1)      not null
#  is_active       :boolean(1)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  old_product_id  :integer(4)
#

class Product < ActiveRecord::Base
  include Prehistoric
  acts_as_fleximage do
    if RAILS_ENV == 'production'
      image_directory "../../shared/uploads/images"
    else
      image_directory 'public/images/uploads'
    end
    require_image false
    default_image_path 'public/images/smiley.gif'
    default_image 'smiley.gif'
  end

  # Thinking Sphinx configuration
  define_index do
    indexes :name, :sortable => true
    indexes description
    indexes comments
    indexes categories.name, :as => :categories_names
    has :is_active
  end

  attr_accessor :post_o_matisize
  before_validation :create_permalink
  belongs_to :caresheet
  has_many :categories, :through => :taxons
  has_many :post_o_matic_postings, :dependent => :destroy
  accepts_nested_attributes_for :post_o_matic_postings, :reject_if => Proc.new { |attributes| attributes.any? { |key,value| value.blank? } }

  has_many :taxons, :dependent => :nullify
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :sku, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }
  named_scope :by_price, lambda { |*args| { :conditions => { :price => [args.first,args.last] } } }
end
