class LeaguesController < ApplicationController
  before_filter :login_required
  
  inherit_resources
  
  custom_actions :member => [:join]

  def join
    flash.notice = "You have joined #{resource.name}. Welcome!"
    
    unless resource.users.where(:id => current_user.id).exists?
      resource.users << current_user
    end
    
    redirect_to resource_path
  end
  
  def leave
    resource.users.delete(current_user)
    
    flash.notice = "You have left #{resource.name}. Sorry to see you go."
    
    redirect_to resource_path
  end
end
