class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  
  validates_presence_of :user_id
  validates_presence_of :band_id
  validates_presence_of :direction
end
