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
    expire_action(:controller => :games, :action => :index)
  end

end