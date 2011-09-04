require 'digest/sha1'

class User < ActiveRecord::Base
  
  # Restrict attributes allowed to be modified on creation
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_secure_password
  
  validates_confirmation_of :password  
  validates_presence_of :password, :on => :create  
  validates_presence_of :email  
  validates_uniqueness_of :email
  
end
