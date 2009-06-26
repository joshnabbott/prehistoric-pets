class CreateAssetResources < ActiveRecord::Migration
  def self.up
    create_table :asset_resources do |t|
      t.belongs_to :asset, :owner, :null => false
      t.string :owner_type, :null => false
      t.boolean :is_active, :null => false, :default => false
      t.integer :position

      t.timestamps
    end
    
    add_index :asset_resources, [:owner_id, :owner_type]
    add_index :asset_resources, :asset_id
  end

  def self.down
    drop_table :asset_resources
  end
end
