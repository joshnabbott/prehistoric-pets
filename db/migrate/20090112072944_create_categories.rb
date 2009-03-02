class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.belongs_to :parent
      t.string :name, :permalink
      t.text :description
      t.boolean :is_active, :is_price_specific, :default => false, :null => false
      t.decimal :starting_price, :ending_price, :precision => 8, :scale => 2, :default => 0.0
      t.integer :position
      t.timestamps
    end
    add_index :categories, :permalink, :unique => true
  end

  def self.down
    drop_table :categories
  end
end
