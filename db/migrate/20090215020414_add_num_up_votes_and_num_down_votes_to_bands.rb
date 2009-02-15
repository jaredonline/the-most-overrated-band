class AddNumUpVotesAndNumDownVotesToBands < ActiveRecord::Migration
  def self.up
    add_column :bands, :num_up_votes, :integer, :default => 1
    add_column :bands, :num_down_votes, :integer, :default => 0
  end

  def self.down
    remove_column :bands, :num_up_votes
    remove_column :bands, :num_down_votes
  end
end
