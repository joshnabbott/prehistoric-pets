class Asset < ActiveRecord::Base
  has_and_belongs_to_many :asset_categories
end