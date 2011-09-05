class Score < ActiveRecord::Base
  belongs_to :game
  
  has_many :players, :dependent => :destroy
  
  accepts_nested_attributes_for :players
  validates_numericality_of :goals, :only_integer => true, :minimum => 0
end
