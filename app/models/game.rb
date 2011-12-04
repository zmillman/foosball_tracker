require 'saulabs/trueskill'

class Game < ActiveRecord::Base
  include Saulabs:: TrueSkill
  
  has_many :teams, :dependent => :destroy
  belongs_to :league
  
  accepts_nested_attributes_for :teams
  
  before_validation :mark_winner, :on => :create
  
  validates_size_of :teams, :is => 2
  validates_each :teams do |record, attr, value|
    record.errors.add '', "One of the teams must have at least 10 goals" if value.select(&:is_winner?).size < 1
    record.errors.add '', "There can't be more than one winner! How did you even get this error?" if value.select(&:is_winner?).size > 1
    
    # TODO check for duplicate players
    #TODO validate scores for overtime games
  end
  
  # Initialize for a doubles match
  def build_for_doubles
    u_ids = league.users.first(4)
    teams.build(:goals => 10 )
    teams.build(:goals => 0)
    teams.each do |s|
      s.players.build({:position => 'Offense', :user_id => u_ids.shift})
      s.players.build({:position => 'Defense', :user_id => u_ids.shift})
    end
  end
  
  # Initialize for a singles match
  def build_for_singles
    u_ids = league.users.first(2)
    2.times{teams.build}
    teams.each do |s|
      s.players.build({:position => 'Offense'})
    end
  end
  
  def mark_winner
    winning_team = teams.reject{|team| team.goals < 10}.sort_by(&:goals).last
    winning_team.is_winner = true unless winning_team.nil?
    
    teams.each do |team|
      team.players.each do |player|
        if self.new_record?
          player.rating = player.user.current_rating
        else
          player.rating = player.user.rating_before(self.created_at)
        end  
      end
    end
    
    team_ratings = teams.sort_by(&:goals).reverse.collect{|team| team.players.collect(&:rating_for_calculation)}
    team_ranks = teams.sort_by(&:goals).reverse.collect{|team| team.is_winner ? 1 : 2}
    
    logger.debug("Ratings:\n" + team_ratings.inspect)
    logger.debug("Rankings:\n" + team_ranks.inspect)
    
    graph = FactorGraph.new(team_ratings, team_ranks)
    
    graph.update_skills

    teams.each do |team|
      team.players.each do |player|
        player.rating = player.rating_for_calculation
      end
    end
  end
  
  def self.recalculate
    scoped.find_each do |game|
      game.mark_winner
      game.save!
    end
  end
end
