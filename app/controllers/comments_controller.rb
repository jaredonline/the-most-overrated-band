class CommentsController < ApplicationController
  
  make_resourceful do
    actions :all
    belongs_to :band
  end
  
end
