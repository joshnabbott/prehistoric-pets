class Crop < ActiveRecord::Base
  belongs_to :image
  belongs_to :crop_definition
  validates_presence_of :crop_definition
  validates_uniqueness_of :image_id, :scope => :crop_definition_id
  validates_uniqueness_of :crop_definition_id, :scope => :image_id
  delegate :name, :to => :crop_definition

  def from
    "#{x}x#{y}"
  end

  def has_valid_sizes?
    !(x.blank? && y.blank? && width.blank? && height.blank?)
  end

  def size
    "#{width}x#{height}"
  end
end
