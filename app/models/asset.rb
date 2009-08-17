# TODO: clean up the way we're expiring the products cache when an asset crop gets updated.
class Asset < ActiveRecord::Base
  after_save :expire_products_cache, :if => Proc.new { ActionController::Base.perform_caching }
  has_and_belongs_to_many :asset_categories
  has_many :asset_resources, :dependent => :destroy

private
  # A bit of hackey to expire the product fragment cache when a crop gets updated
  # Crop belongs to image with touch => true enabled on save
  # When image gets updated, it should touch each product record associated to it through the asset_resources table
  # When an asset_resource gets updated, it should touch it's owner object.
  # This seems ugly, but will work for now.
  def expire_products_cache
    self.asset_resources.map(&:touch)
  end
end