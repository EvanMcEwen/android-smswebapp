class User < ActiveRecord::Base
  has_secure_password

  has_many :devices
  has_many :messages
  
  attr_accessible :email, :password, :password_confirmation
  
  def self.authenticate(user, pass)
    user = User.where(:username => user).first.try(:authenticate, pass)
  end
  
  private
  validates :username, :length => { :in => 3..20 }, :uniqueness => true, :presence => true
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, :uniqueness => true
end