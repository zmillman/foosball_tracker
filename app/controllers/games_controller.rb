class GamesController < ApplicationController
  before_filter :login_required
  
  caches_action :show, :layout => false
  cache_sweeper :game_sweeper
  
  inherit_resources
  belongs_to :league
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
end
