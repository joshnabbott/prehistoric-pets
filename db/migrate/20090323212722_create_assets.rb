class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :type, :name
      t.text :description
      t.integer :size, :image_width, :image_height

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
