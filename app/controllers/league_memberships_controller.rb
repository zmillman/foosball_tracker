class LeagueMembershipsController < ApplicationController
  inherit_resources
  belongs_to :league
  actions :create, :destroy
  
  def create
    create!{league_path(resource.league)}
  end
  
  def destroy
    destroy!{parent_collection_path}
  end
end
