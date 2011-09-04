class UsersController < ApplicationController
  
  inherit_resources
  
  def create
    create! do
      current_user = resource
      return resource_path
    end
  end
  
  private
  
  def resource
    @user = current_user
  end
  
end
