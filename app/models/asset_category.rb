class AssetCategory < ActiveRecord::Base
  has_many :crop_definitions, :dependent => :destroy
  has_and_belongs_to_many :assets
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_nil => true
end
