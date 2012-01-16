# Taken from http://techno-weenie.net/2008/2/6/timezone-awareness-in-rails/

# This module expects timezone.js to be included on the page, which will set the tzoffset cookie
module BrowserTimezone
  
  protected
  
  def browser_timezone
    return nil if cookies[:tzoffset].blank?
    @browser_timezone ||= begin
      min = cookies[:tzoffset].to_i
      ActiveSupport::TimeZone[-min.minutes]
    end
  end
  
  def set_timezone
    Time.zone = browser_timezone
  end
  
  def self.included(base)
    base.send :helper_method, :browser_timezone, :set_timezone if base.respond_to? :helper_method
  end
end