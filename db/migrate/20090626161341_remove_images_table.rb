class RemoveImagesTable < ActiveRecord::Migration
  def self.up
    drop_table :images
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't recover images table."
  end
end
