class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :band_id
      t.integer :user_id
      t.string :name, :default => "Anonymous Coward"
      t.string :email
      t.string :website
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
