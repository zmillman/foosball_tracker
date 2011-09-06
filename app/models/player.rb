class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_one :game, :through => :team
  
  validates_inclusion_of :position, :in => ['Offense', 'Defense']
end
