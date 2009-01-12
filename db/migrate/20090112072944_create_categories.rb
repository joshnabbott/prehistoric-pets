class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.belongs_to :parent
      t.string :name
      t.text :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
