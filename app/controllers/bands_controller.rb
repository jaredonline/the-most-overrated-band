class BandsController < ApplicationController
  layout 'application'
  
  make_resourceful do
    actions :all
  end
  
  def index
    @winner = Band.find(:first, :order => "num_votes DESC")
    @bands = Band.find(:all, :conditions => "id != #{@winner.id}", :order => "num_votes DESC")
  end
  
  def show
    redirect_to "/"
  end
  
  def up
    vote = Vote.find(:all, :conditions => "user_id = #{@user.id} AND band_id = #{params[:id]}")
    if vote.length == 0
      vote = Vote.new(:band_id => params[:id], :user_id => @user.id, :direction => 1)
      vote.save
      band = Band.find(params[:id])
      band.num_votes = band.num_votes.next
      band.save
    else
      flash[:error] = "You already voted on that band this week.  Come back after midnight on Sunday."
    end
    redirect_to "/"
  end
  
  def down
    vote = Vote.find(:all, :conditions => "user_id = #{@user.id} AND band_id = #{params[:id]}")
    if vote.length == 0  
      vote = Vote.new(:band_id => params[:id], :user_id => @user.id, :direction => -1)
      vote.save
      band = Band.find(params[:id])
      band.num_votes = band.num_votes - 1
      band.save
    else
      flash[:error] = "You already voted on that band this week.  Come back after midnight on Sunday."
    end
    redirect_to "/"
  end
  
end
