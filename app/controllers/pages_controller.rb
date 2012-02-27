class PagesController < ApplicationController
  def home
    if current_user
      redirect_to games_path
    end
  end
end
