class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.belongs_to :parent
      t.string :name, :permalink
      t.text :description
      t.integer :position
      t.timestamps
    end
    add_index :categories, :permalink, :unique => true
  end

  def self.down
    drop_table :categories
  end
end
