class AuthController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:login, :logout]
  
  def login
    session[:user_id] = User.authenticate(params[:username], params[:password]) if params[:username]
    update_session_expiry
    
    respond_to do |format|
      if !session[:user_id].nil?
        format.html { redirect_to '/' }
        format.json { render :json => {:status => 1} }
      else
        format.json { render :json => {:status => 0} }
      end
    end
  end

  def logout
  	reset_session

  	redirect_to '/login'
  end
end
