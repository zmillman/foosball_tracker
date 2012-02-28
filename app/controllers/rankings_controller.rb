class RankingsController < ApplicationController
  before_filter :login_required
  
  def show
    @players = Player.where(['players.created_at > ?', 30.days.ago])
  end
end
