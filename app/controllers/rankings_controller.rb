class RankingsController < ApplicationController
  before_filter :login_required
  
  def show
    @games = Game.limit(100).order('games.created_at DESC')
  end
end
