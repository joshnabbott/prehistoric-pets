class Product < ActiveRecord::Base
  include Prehistoric
  attr_accessor :post_o_matisize, :post_o_matic_category_id
  acts_as_fleximage :image_directory => 'public/images/uploads'
  after_save :schedule_for_post_o_matic, :if => Proc.new { |record| record.post_o_matisize }
  before_validation :create_permalink
  belongs_to :caresheet
  belongs_to :category
  has_many :post_o_matic_postings, :dependent => :destroy
  validates_presence_of :name, :sku, :price, :permalink
  validates_uniqueness_of :name, :sku, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }
private
  def schedule_for_post_o_matic
    self.post_o_matic_postings.create(:product => self, :post_o_matic_category_id => self.post_o_matic_category_id)
  end
end