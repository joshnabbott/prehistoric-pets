class CreateAssetCategoriesAssets < ActiveRecord::Migration
  def self.up
    create_table :asset_categories_assets, :id => false do |t|
      t.belongs_to :asset, :asset_category
    end
  end

  def self.down
    drop_table :asset_categories_assets
  end
end
