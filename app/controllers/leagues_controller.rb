class LeaguesController < InheritedResources::Base
  before_filter :login_required, :except => [:index, :show]
  
  def create
    @league = League.new(params[:league])
    @league.owner = current_user
    create!
  end
end
