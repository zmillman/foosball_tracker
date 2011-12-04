class LeaguesController < InheritedResources::Base
  before_filter :login_required, :except => [:index, :show]
  
  def create
    @league = League.new(params[:league])
    @league.owner = current_user
    create!
  end
  
  def recalculate_ranks
    @league = League.find(params[:id])
    @league.games.recalculate
    
    flash.notice = 'Rankings recalculated'
    
    redirect_to @league
  end
end
