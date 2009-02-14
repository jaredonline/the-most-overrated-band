class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  
  validates_presence_of :body
  
  def link
    if self.website != ''
      website
    elsif email != ''
      'mailto:' + email
    end
  end
end
