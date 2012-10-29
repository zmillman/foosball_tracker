class League < ActiveRecord::Base

  has_many :league_memberships, :dependent => :destroy
  has_many :users, :through => :league_memberships
  
  has_many :games
  
end
