class SessionsController < ApplicationController
  
  inherit_resources
  actions :new, :create, :destroy
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      flash.now.notice = "Hello"
      self.current_user = user
      redirect_to user
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    current_user = nil
    redirect_to login_path
  end
  
end
