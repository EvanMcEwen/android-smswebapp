class HomeController < ApplicationController
  def index
    @conversations = get_conversations(params[:number])
  end


  private
  def get_conversations(number)
    if (number.nil?)
      messages = Message.find_all_by_user_id(session[:user_id], :order => "timestamp DESC")
    else
      messages = Message.find_all_by_user_id(session[:user_id], :conditions => ["origin = ? OR destination = ?",number,number], :order => "timestamp DESC")
    end

  	contacts = []
  	for msg in messages
  		contacts.push(msg.origin) if !contacts.include?(msg.origin) && !msg.origin.eql?("DEVICE")
  	end
  	return contacts
  end
end
