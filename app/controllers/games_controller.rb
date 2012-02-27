class GamesController < ApplicationController
  before_filter :login_required
  
  has_scope :page, :default => 1
  
  caches_action :show, :layout => false
  cache_sweeper :game_sweeper
  
  inherit_resources
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
  
  def recalculate_ranks
    Game.recalculate_ratings!
    
    flash.notice = 'Rankings recalculated'
    
    redirect_to collection_path
  end
end
