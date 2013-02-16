class GamesController < ApplicationController
  before_filter :login_required
  before_filter :authorize_for_delete, :only => :delete
  
  has_scope :page, :default => 1
  has_scope :most_recent, :type => :boolean, :default => true
  
  inherit_resources
  
  belongs_to :league
  
  respond_to :html
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
  
  def create
    create! {params[:create_and_new] ? new_resource_path : resource_path}
  end
  
  protected
  
  def authorize_for_delete
    unless resource.users.include?(current_user)
      flash.notice = 'You must have played in a game to be allowed to delete it'
      redirect_to resource_path
    end
  end
  
  private
  
  def interpolation_options
    { :winners_names => resource.winners.collect(&:name).join(' and ') }
  end
end
