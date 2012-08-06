class SearchController < ApplicationController
  def lookfor
  	query = params[:searchQuery]
  	@results = Message.find_all_by_user_id(session[:user_id], :conditions => ["message LIKE ?","%" + query + "%"], :order => "timestamp DESC")
  end
end
