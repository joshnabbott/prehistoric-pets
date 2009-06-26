class CreateCropDefinitions < ActiveRecord::Migration
  def self.up
    create_table :crop_definitions do |t|
      t.belongs_to :asset_category
      t.string :name
      t.integer :minimum_width, :minimum_height, :x, :y, :null => false, :default => 0
      t.boolean :is_specific, :null => false, :default => false

      t.timestamps
    end
    
    add_index :crop_definitions, [:name, :asset_category_id]
  end

  def self.down
    drop_table :crop_definitions
  end
end