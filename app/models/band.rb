class Band < ActiveRecord::Base
  has_many :votes
  has_many :comments
  
  validates_presence_of :name
  
  def before_save
    write_attribute('permalink', name.parameterize.to_s)
  end
  
  def before_update
    write_attribute('permalink', name.parameterize.to_s)
  end
  
  def url_escape
    self.name.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end.tr(' ', '+')
  end
  
  def to_param
    permalink
  end
  
  def num_votes_formatted
    if num_votes > 0
      '+' + num_votes.to_s
    else
      num_votes.to_s
    end
  end
end
