require 'saulabs/trueskill'

class Game < ActiveRecord::Base
  include Saulabs:: TrueSkill

  belongs_to :league
  
  has_many :teams, :dependent => :destroy
  has_many :players, :through => :teams
  has_many :users, :through => :players

  accepts_nested_attributes_for :teams

  before_validation :mark_winner, :unless => :winner_marked?
  after_save :invalidate_following_games
  after_destroy :invalidate_following_games

  validates_size_of :teams, :is => 2
  validates_each :teams do |record, attr, value|
    record.errors.add '', "One of the teams must have at least 10 goals" if value.select(&:is_winner?).size < 1
    record.errors.add '', "There can't be more than one winner! How did you even get this error?" if value.select(&:is_winner?).size > 1

    # TODO check for duplicate players
    #TODO validate scores for overtime games
  end

  scope :with_rating_pending, where(:rating_pending => true)
  scope :rating_current, where(:rating_pending => false)
  scope :most_recent, order('games.created_at DESC')
  def self.before(game)
    where(['games.created_at < ? AND games.id != ?', (game.created_at || Time.now), ((game && game.id) || nil)])
  end
  def self.after(game)
    where(['games.created_at > ? AND games.id != ?', (game.created_at || Time.now), ((game && game.id) || nil)])
  end

  def name
    "Game #{id}"
  end

  # Initialize for a doubles match
  def build_for_doubles
    teams.build(:goals => 10 )
    teams.build(:goals => 0)
    teams.each do |s|
      s.players.build({:position => 'Offense', :user => User.first})
      s.players.build({:position => 'Defense', :user => User.first})
    end
  end

  # Mark the winning team
  def mark_winner
    winning_team = teams.reject{|team| team.goals < 10}.sort_by(&:goals).last
    winning_team.is_winner = true unless winning_team.nil?
    self.goals_count = teams.collect(&:goals).inject(&:+)

    if rating_pending? && !Game.before(self).with_rating_pending.exists?
      set_ratings
    end
    return true
  end
  
  def winner_marked?
    teams.select(&:is_winner?).size == 1
  end

  # Assign ratings to the players
  def set_ratings
    # Prepare players with their ratings
    teams.each do |team|
      team.players.each {|player| player.rating = player.user.rating_before_game(self)}
    end
    
    # Run the factor graph algorithm
    team_ratings = teams.sort_by(&:goals).reverse.collect{|team| team.players.collect(&:rating_for_calculation)}
    team_ranks = teams.sort_by(&:goals).reverse.collect{|team| team.is_winner ? 1 : 2}
    FactorGraph.new(team_ratings, team_ranks).update_skills

    teams.each do |team|
      team.players.each do |player|
        player.rating = player.rating_for_calculation
      end
    end

    self.rating_pending = false # finally done!
    return true
  end

  def self.rate_pending_games!
    with_rating_pending.order('created_at ASC').all.each do |game|
      logger.info "Rating Game ##{game.id}"
      game.set_ratings
      raise 'Rating failed!' if game.rating_pending
      game.save!
    end
  end

  def self.reset_ratings!
    update_all(:rating_pending => true)
  end

  protected

  def invalidate_following_games
    unless rating_pending?
      following_rated_games = Game.rating_current.after(self)
      if following_rated_games.exists?
        logger.info "Resetting the rating for #{following_rated_games.count} games"
        following_rated_games.reset_ratings!
        Game.rate_pending_games!
      end
    end
  end
end
