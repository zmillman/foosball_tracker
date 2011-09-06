class League < ActiveRecord::Base
  has_many :games, :dependent => :destroy
  has_many :league_memberships, :dependent => :destroy
  has_many :users, :through => :league_memberships
  belongs_to :owner, :class_name => 'User'
  
  validates_presence_of :owner
  validates_length_of :name, :minimum => 1
  
  def authorized?(action, user)
    case action
      when :new_game
      return users.include?(user)
      
      when :edit
      return owner == user
    end
  end
  
  before_validation do
    if owner_id_changed?
      self.users << owner
    end
  end
  
end
