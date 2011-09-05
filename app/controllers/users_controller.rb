class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :create]
  
  inherit_resources
  
  def create
    create! do |success, failure|
      success.all do
        self.current_user = resource
        redirect_to dashboard_path
      end
    end
  end
end