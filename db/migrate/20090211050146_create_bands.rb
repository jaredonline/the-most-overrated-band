class CreateBands < ActiveRecord::Migration
  def self.up
    create_table :bands do |t|
      t.string :name
      t.integer :rank, :default => 0
      t.integer :votes, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :bands
  end
end
