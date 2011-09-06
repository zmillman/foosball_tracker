class Team < ActiveRecord::Base
  belongs_to :game
  
  has_many :players, :dependent => :destroy
  
  accepts_nested_attributes_for :players
  
  validates_numericality_of :goals, :only_integer => true, :minimum => 0
  
  validates_each :goals do |record, attr, value|
    if record.overtime?
      if record.is_winner?
        record.errors.add attr, "must win by 2" unless record.game.teams.collect(&:goals).min == value - 2
      else
        record.errors.add attr, "must lose by 2" unless record.game.teams.collect(&:goals).min == value + 2
      end
    else
      if record.is_winner?
        record.errors.add attr, "must have at least 10 goals to win" unless value >= 10
      end
    end
  end
  
  def overtime?
    is_winner ? goals > 10 : goals > 8
  end
end
