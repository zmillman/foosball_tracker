class UserSweeper < ActionController::Caching::Sweeper
  observe User

  def after_save(user)
    expire_cache(user)
  end

  def after_destroy(user)
    expire_cache(user)
  end

  private

    def expire_cache(user)
      # expire_page users_path 
      expire_page user_path(user)
      user.leagues.each do |league|
        expire_page league_path(league)
      end
    end

end