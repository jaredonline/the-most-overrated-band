class CreatePermalinks < ActiveRecord::Migration
  def self.up
    add_column :bands, :permalink, :string
  end

  def self.down
    remove_column :bands, :permalink
  end
end
