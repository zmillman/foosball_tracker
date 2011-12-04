class GamesController < ApplicationController
  before_filter :login_required
  
  caches_page :show
  cache_sweeper :game_sweeper
  
  inherit_resources
  belongs_to :league
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
end
