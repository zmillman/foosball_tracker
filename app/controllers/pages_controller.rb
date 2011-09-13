class PagesController < ApplicationController
  def home
    if current_user
      redirect_to dashboard_path
    end
  end
end
