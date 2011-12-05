class GameSweeper < ActionController::Caching::Sweeper
  observe Game

  def after_save(game)
    expire_cache(game)
  end

  def after_destroy(game)
    expire_cache(game)
  end

  private

    def expire_cache(game)
      expire_action(:controller => :leagues, :action => :show, :id => game.league_id)
      expire_action(:controller => :games, :action => :show, :id => game.id, :league_id => game.league_id)
    end

end