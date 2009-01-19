class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.belongs_to :owner
      t.string :owner_type, :null => false
      t.text :description
      t.boolean :is_active, :is_default, :default => false, :null => false
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
