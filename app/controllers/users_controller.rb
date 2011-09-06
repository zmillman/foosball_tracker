class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :create]
  
  inherit_resources
  actions :show, :new, :create, :edit, :update
  
  def create
    create! do |success, failure|
      success.all do
        self.current_user = resource
        redirect_to dashboard_path
      end
    end
  end
  
  private
  
  def interpolation_options
    {:user_name => resource.name}
  end
end