class Synchash < ActiveRecord::Base
  belongs_to :user

  private
  validates :user_id, :uniqueness => true, :presence => true
end
