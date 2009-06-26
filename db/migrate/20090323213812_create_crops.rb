class CreateCrops < ActiveRecord::Migration
  def self.up
    create_table :crops do |t|
      t.belongs_to :image, :null => false
      t.belongs_to :crop_definition
      t.integer :x, :y, :width, :height, :null => false

      t.timestamps
    end
    add_index :crops, [:crop_definition_id, :image_id]
  end

  def self.down
    drop_table :crops
  end
end
