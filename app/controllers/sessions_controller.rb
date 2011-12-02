class SessionsController < ApplicationController
  
  inherit_resources
  actions :new, :create, :destroy
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      self.current_user = user
      if current_user.leagues.exists?
        redirect_to [current_user.leagues.first]
      else
        redirect_to dashboard_path
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    self.current_user = nil
    redirect_to login_path
  end
  
end
