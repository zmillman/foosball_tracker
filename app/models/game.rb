class Game < ActiveRecord::Base
  has_many :teams
  belongs_to :league
  
  accepts_nested_attributes_for :scores
  
  before_validation :mark_winner, :on => :create
  
  validates_size_of :scores, :is => 2
  validates_each :scores do |record, attr, value|
    record.errors.add attr, "There must be a winner" if value.select(&:is_winner?).size < 1
    record.errors.add attr, "There mustn't be more than one winner" if value.select(&:is_winner?).size > 1
  end
  
  # Initialize for a doubles match
  def build_for_doubles
    2.times{scores.build}
    scores.each{|s| s.players.build({:position => 'Offense'}); s.players.build({:position => 'Defense'})}
  end
  
  # Initialize for a singles match
  def build_for_singles
    2.times{scores.build}
    scores.each{|s| s.players.build({:position => 'Offense'})}
  end
  
  def mark_winner
    scores.sort_by(&:goals).last.is_winner = true
  end
end
