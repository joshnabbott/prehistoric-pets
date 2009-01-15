class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.string  :title_short
      t.text    :body_short
      t.string  :title_long
      t.text    :body_long
      t.boolean :is_featured, :is_active, :default => false, :null => false
      t.string  :permalink, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
