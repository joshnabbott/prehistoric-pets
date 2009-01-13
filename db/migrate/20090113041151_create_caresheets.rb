class CreateCaresheets < ActiveRecord::Migration
  def self.up
    create_table :caresheets do |t|
      t.string :name, :scientific_name, :permalink
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :caresheets
  end
end
