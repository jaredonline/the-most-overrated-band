class Band < ActiveRecord::Base
  has_many :votes
  
  validates_presence_of :name
  
  def url_escape
    self.name.gsub(/([^ a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end.tr(' ', '+')
  end
end
