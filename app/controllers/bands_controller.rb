class BandsController < ApplicationController
  layout 'application'
  require 'hpricot'
  require 'open-uri'
  
  make_resourceful do
    actions :all
  end
  
  def index
    @winner = Band.find(:first, :order => "num_votes DESC")
    @bands = Band.find(:all, :conditions => "id != #{@winner.id}", :order => "num_votes DESC")
  end
  
  def create
    @band = Band.new(params[:band])
    
    band_names = []
    doc = Hpricot.XML(open('http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=' + @band.name.parameterize.to_str + '&api_key=' + LASTFM_API_KEY))
    
    (doc/"artist/name").each do |artist_name|
       band_names << artist_name.inner_html
    end
    
    
      if band_names.include?(@band.name)
       unless Band.exists?(:name => @band.name)
          if @band.save
            flash[:notice] = 'Band was successfully created.'
            redirect_to(@band)
            # format.xml  { render :xml => @band, :status => :created, :location => @band }
          else
            flash[:error] = "Unable to save band for some reason."
            render :action => "new"
            # format.xml  { render :xml => @band.errors, :status => :unprocessable_entity }
          end
        else
          @band = Band.find_by_name(params[:band][:name])
          redirect_to up_band_path(@band)
        end
      else
        flash[:error] = "That's not a real band."
        @suggestions = band_names
        render :action => "new"
      end
    
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
