class CreateCaresheets < ActiveRecord::Migration
  def self.up
    create_table :caresheets do |t|
      t.string :name, :scientific_name, :permalink
      t.text :body
      t.boolean :is_active, :default => false, :null => false
      t.timestamps
    end
    add_index :caresheets, :permalink, :unique => true
  end

  def self.down
    drop_table :caresheets
  end
end
