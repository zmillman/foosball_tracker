class GamesController < ApplicationController
  before_filter :login_required
  
  inherit_resources
  actions :new, :create, :update, :destroy
  belongs_to :league
  
  def new
    new! do
      resource.build_for_doubles
    end
  end
end
