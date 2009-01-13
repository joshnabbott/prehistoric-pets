class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.belongs_to :category, :caresheet
      t.string :name, :scientific_name
      t.string :sku, :limit              => 10, :null => false
      t.text :description, :comments
      t.decimal :price, :precision       => 8, :scale => 2, :default => 0.0, :null => false
      t.boolean :is_featured, :default   => false, :null => false
      t.boolean :has_caresheet, :default => false, :null => false
      t.boolean :override, :default      => false, :null => false
      t.boolean :is_active, :default     => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end