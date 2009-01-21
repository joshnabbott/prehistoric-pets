class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.belongs_to :user
      t.string :ip_address, :reference_number
      t.string :state, :default => 'in_cart', :null => false
      t.integer :line_items_count, :default => 0
      t.decimal :shipping, :subtotal, :tax, :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.timestamps
    end
    add_index :orders, :reference_number, :unique => true
    add_index :orders, [:reference_number, :state]
    add_index :orders, :state
    add_index :orders, :ip_address
  end

  def self.down
    drop_table :orders
  end
end
