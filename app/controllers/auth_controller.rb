class AuthController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:login, :logout, :mobile_login]
  
  def login
    user = User.authenticate(params.delete(:username), params.delete(:password))
    
    if user
      session[:user_id] = user
      update_session_expiry
    end
    redirect_to '/' if !session[:user_id].nil?
  end

  def mobile_login
    user = User.authenticate(params.delete(:username), params.delete(:password))

    if user
      render :json => {:valid => 1}
    else
      render :json => {:valid => 0}
    end
  end

  def logout
  	reset_session

  	redirect_to '/login'
  end
end
