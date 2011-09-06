class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team, :inverse_of => :players
  has_one :game, :through => :team
  
  validates_inclusion_of :position, :in => ['Offense', 'Defense']
  validates_presence_of :user
end
