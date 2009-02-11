class User < ActiveRecord::Base
  has_many :votes
  
  validates_presence_of :user_key
end
