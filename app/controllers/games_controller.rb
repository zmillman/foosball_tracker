class GamesController < ApplicationController
  before_filter :login_required
  before_filter :authorize_for_delete, :only => :delete
  
  has_scope :page, :default => 1
  has_scope :most_recent, :type => :boolean, :default => true
  
  inherit_resources
  
  belongs_to :league
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
  
  protected
  
  def authorize_for_delete
    unless resource.users.include?(current_user)
      flash.notice = 'You must have played in a game to be allowed to delete it'
      redirect_to resource_path
    end
  end
end
