class CropDefinition < ActiveRecord::Base
  belongs_to :asset_category
  has_many :crops, :dependent => :destroy
  validates_presence_of :name, :minimum_width, :minimum_height
  validates_uniqueness_of :name, :scope => :asset_category_id

  def height
    minimum_height
  end

  def width
    minimum_width
  end
end
