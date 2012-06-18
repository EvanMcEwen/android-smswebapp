class AuthController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:login, :logout, :mobile_login]
  
  def login
    session[:user_id] = User.authenticate(params[:username], params[:password]) if params[:username]
    update_session_expiry
    
    redirect_to '/' if !session[:user_id].nil?
  end

  def mobile_login
    session[:user_id] = User.authenticate(params[:username], params[:password]) if params[:username]

    render :json => {:status => 1} if !session[:user_id].nil?
  end

  def logout
  	reset_session

  	redirect_to '/login'
  end
end
