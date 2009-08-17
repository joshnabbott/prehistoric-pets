class CreateShippingCategories < ActiveRecord::Migration
  def self.up
    create_table :shipping_categories do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0, :null => false

      t.timestamps
    end
    add_index :shipping_categories, :name
  end

  def self.down
    drop_table :shipping_categories
  end
end
