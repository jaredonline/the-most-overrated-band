# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5f91473fe2c47ab4573035cf029a8e6f'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :create_cookie
  before_filter :get_user
  
  def create_cookie
    if cookies[:user_key].nil?
      cookies[:user_key] = {:value => remember_token, :expires => remember_token_expires}
    end
  end
  
  def get_user
    @user ||= User.find_or_create_by_user_key(cookies[:user_key])
  end
  
  def remember_token_expires
    2.weeks.from_now
  end
  
  def remember_token
    salt = [Array.new(6){rand(256).chr}.join].pack("m")[0..7];
    Digest::SHA1.hexdigest("#{salt}--#{self.remember_token_expires}--#{Time.now}")
  end
end
