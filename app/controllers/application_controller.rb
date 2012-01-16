require 'browser_timezone'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include BrowserTimezone
  before_filter :set_timezone
  
  protected
  
  helper_method :current_user
  def current_user 
    logger.debug("user_id: #{session[:user_id]}")
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user=(user)
    @current_user = user
    session[:user_id] = (user ? user.id : nil)
    logger.debug("user_id set to: #{session[:user_id]}")
  end
  
  def login_required
    current_user || redirect_to(login_path, :error => 'Sorry, you have to log in') 
  end
  
end
