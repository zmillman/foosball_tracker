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
      # expire_page games_path 
      expire_page league_game_path(game.league, game)
      expire_page league_path(game.league)
    end

end