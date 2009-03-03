class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.belongs_to :caresheet
      t.string :name, :scientific_name, :permalink
      t.string :sku, :limit => 10, :null => false
      t.text :description, :comments
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.boolean :is_featured, :override, :is_active, :default => false, :null => false
      t.timestamps
    end
    add_index :products, :permalink
    # add_index :products, :permalink, :unique => true
  end

  def self.down
    drop_table :products
  end
end