class User < ActiveRecord::Base
  has_many :votes
  has_many :comments
  
  validates_presence_of :user_key
end
