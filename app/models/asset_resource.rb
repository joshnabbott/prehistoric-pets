class AssetResource < ActiveRecord::Base
  default_scope :order => 'position asc'

  belongs_to :asset
  belongs_to :owner, :polymorphic => true
end