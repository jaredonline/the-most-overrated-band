class CreateBands < ActiveRecord::Migration
  def self.up
    create_table :bands do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bands
  end
end
