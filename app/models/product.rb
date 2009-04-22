class Product < ActiveRecord::Base
  include Prehistoric
  acts_as_fleximage do
    image_directory 'public/assets/images'
    default_image 'smiley.gif'
    default_image_path 'public/images/smiley.gif'
    image_storage_format :jpg
    require_image false
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
  named_scope :by_price_range, lambda { |*args| { :conditions => { :price => [args.first,args.last] } } }
end
