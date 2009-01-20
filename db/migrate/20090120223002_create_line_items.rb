class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.belongs_to :order, :product
      t.integer :quantity, :default => 1, :null => false
      t.decimal :price, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.timestamps
    end
    add_index :line_items, :order_id
    add_index :line_items, :product_id
    add_index :line_items, [:order_id, :product_id]
  end

  def self.down
    drop_table :line_items
  end
end
