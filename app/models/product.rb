class Product < ActiveRecord::Base
  include Prehistoric

  attr_accessor :post_o_matisize
  before_validation :create_permalink
  belongs_to :caresheet
  belongs_to :shipping_category
  has_many :categories, :through => :taxons
  has_many :post_o_matic_postings, :dependent => :destroy
  accepts_nested_attributes_for :post_o_matic_postings, :reject_if => Proc.new { |attributes| attributes.any? { |key,value| value.blank? } }

  has_many :taxons, :dependent => :nullify
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :sku, :allow_nil => true

  # Asset associations
  has_many :asset_resources, :as => :owner, :dependent => :destroy
  has_many :images, :through => :asset_resources, :source => :asset, :class_name => 'Image' do
    def default(reload = false)
      @default = nil if reload
      @default ||= find(:first)
    end
  end

  # Thinking Sphinx configuration
  define_index do
    indexes :name, :sortable => true
    indexes description
    indexes comments
    indexes categories.name, :as => :categories_names
    has :is_active
  end

  named_scope :active, :joins => :images, :conditions => ['products.is_active = ? AND assets.`id` IS NOT NULL', true]
  named_scope :featured, :conditions => { :is_featured => true }
  named_scope :by_price_range, lambda { |*args| { :conditions => { :price => [args.first,args.last] } } }

  def can_display?
    (is_active && images.count > 0)
  end
end
