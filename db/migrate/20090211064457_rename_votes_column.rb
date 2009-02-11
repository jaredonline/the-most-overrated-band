class RenameVotesColumn < ActiveRecord::Migration
  def self.up
    remove_column :bands, :votes
    add_column :bands, :num_votes, :integer, :default => 1
  end

  def self.down
    remove_column :bands, :num_votes
    add_column :bands, :votes, :integer, :default => 0
  end
end
