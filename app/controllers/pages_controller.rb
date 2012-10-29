class PagesController < ApplicationController
  def home
    if current_user
      redirect_to leagues_path
    end
  end
end
