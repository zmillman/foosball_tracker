class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :score
  
#  validates_inclusion_of :position, :in => ['Offense', 'Defense']
end
