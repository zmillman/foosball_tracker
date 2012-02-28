require 'saulabs/trueskill'
class Player < ActiveRecord::Base
  include Saulabs::TrueSkill
  belongs_to :user
  belongs_to :team, :inverse_of => :players
  has_one :game, :through => :team
  
  validates_inclusion_of :position, :in => ['Offense', 'Defense']
  validates_presence_of :user
  
  @default_skill_mean = 25.0
  @default_skill_deviation = @default_skill_mean / 3
  @max_skill_mean = @default_skill_mean * 2
  @min_skill_mean = 0
  
  def self.most_recent
    order('players.created_at DESC')
  end
  
  #TODO: restrict skill_mean with @@max/min_skill_mean
  def rating=(r)
    self.skill_mean = r.mean
    self.skill_deviation = r.deviation
  end
  
  def rating
    Rating.new((skill_mean || 0), (skill_deviation || 0))
  end
  
  def rank
    [(skill_mean - 3 * skill_deviation), 0].max
  end
  
  def rank_delta
    Player.rank(self.rating) - Player.rank(user.rating_before(self.created_at))
  end
  
  #temporary copy of rating for Game to use in its rating calculations
  def rating_for_calculation
    @rating_for_calculation ||= self.rating
  end
  
  def self.flot_series(options = {})
    (options[:users] || User.all).collect do |user|
      {
        :label => user.name,
        :data => scoped.where(:user_id => user.id).order('players.created_at ASC').collect{|p| [p.created_at.to_i * 1000, p.rank.to_f, p.skill_mean.to_f]}
      }
    end
  end
  
  def self.default_rating
    Rating.new(@default_skill_mean, @default_skill_deviation)
  end
  
  def self.rank(rating)
    [rating.mean - 3 * rating.deviation, 0].max
  end
end
