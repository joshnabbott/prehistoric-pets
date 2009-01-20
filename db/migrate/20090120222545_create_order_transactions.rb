class CreateOrderTransactions < ActiveRecord::Migration
  def self.up
    create_table :order_transactions do |t|
      t.belongs_to :order
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.boolean :is_success, :is_test, :default => false, :null => false
      t.string :reference_number, :action, 
      t.text :message, :params
      t.timestamps
    end
    add_index :order_transactions, :reference_number
  end

  def self.down
    drop_table :order_transactions
  end
end
