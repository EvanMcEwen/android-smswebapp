class HomeController < ApplicationController
  def index
  	@conversations = get_conversations()
  end


  private
  def get_conversations()
  	messages = Message.find_all_by_user_id(session[:user_id], :order => "timestamp DESC")

  	contacts = []
  	for msg in messages
  		contacts.push(msg.origin) if !contacts.include?(msg.origin) && !msg.origin.eql?("DEVICE")
  	end
  	return contacts
  end
end
