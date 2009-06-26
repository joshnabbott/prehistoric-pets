class CreateAssetCategories < ActiveRecord::Migration
  def self.up
    create_table :asset_categories do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :asset_categories, :name
  end

  def self.down
    drop_table :asset_categories
  end
end
