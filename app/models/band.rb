class Band < ActiveRecord::Base
  has_many :votes
  
  validates_presence_of :name
end
