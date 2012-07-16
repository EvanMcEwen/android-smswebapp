class Synchash < ActiveRecord::Base
  belongs_to :user

  private
  validates :user, :uniqueness => true, :presence => true
end
