class Game < ActiveRecord::Base
  has_many :scores
  belongs_to :league
  
  accepts_nested_attributes_for :scores
  
  validates_size_of :scores, :is => 2
  
  def build_for_doubles
    
      2.times{scores.build}
      scores.map{|s| s.players.build({:position => 'Offense'}); s.players.build({:position => 'Defense'})}
  end
end
