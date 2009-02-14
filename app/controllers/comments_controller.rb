class CommentsController < ApplicationController
  
  def create
    @band = Band.find_by_permalink(params[:band_id])
    @comment = @band.comments.new(params[:comment])
    
    if @comment.save
      redirect_to band_path(@comment.band)
    else
      flash[:error] = "Couldn't save your comment for some reason.  Sorry 'bout that."
      redirect_to band_path(@comment.band)
    end
  end
  
end
