require 'digest/sha1'

class User < ActiveRecord::Base
  # Gives the user a gravatar_url method
  include Gravtastic
  is_gravtastic! 
  
  has_secure_password
  
  # Restrict attributes allowed to be modified on creation
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :players
  has_many :teams, :through => :players
  has_many :games, :through => :teams
  
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create
  validates_length_of :password, :on => :create, :minimum => 6
  validates_presence_of :email  
  validates_uniqueness_of :email
  validates_length_of :name, :minimum => 1
  
  def win_rate
    if losses_count + wins_count > 0
      1.0 * (wins_count - losses_count) / (wins_count + losses_count)
    else
      0      
    end
  end
  
  def wins
    games.merge(Team.where(:is_winner => true))
  end
  
  def losses
    games.merge(Team.where(:is_winner => false))
  end
  
  def wins_count
    teams.where(:is_winner => true).count
  end
  
  def losses_count
    teams.where(:is_winner => false).count
  end
  
  def current_rank
    Player.rank(current_rating)
  end
  
  def current_rating
    if players.exists?
      players.most_recent.first.rating
    else
      Player.default_rating
    end
  end
  
  # Gives the most recent rating before time
  def rating_before(time)
    prev_player = players.where(['players.created_at < ?', time]).most_recent.first
    if prev_player
      prev_player.rating
    else
      Player.default_rating
    end
  end
  def rating_before_game(game)
    rating_before(game.created_at || Time.now)
  end
  
  def self.order_by_ranking
    scoped.sort_by(&:rating)
  end
end
