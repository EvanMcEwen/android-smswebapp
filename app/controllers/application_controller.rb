class ApplicationController < ActionController::Base
  before_filter :ensure_user_logged_in, :except => [:login, :logout, :mobile_login]
  before_filter :session_expiry, :except => [:login, :logout, :mobile_login]
  before_filter :update_session_expiry, :except => [:login, :logout, :mobile_login]

  
  private
  def ensure_user_logged_in
    return if logged_in
    
    redirect_to '/login'
  end
  
  def logged_in
    return true if session[:user_id]
  end

  def update_session_expiry
    session[:expires_at] = 60.minutes.from_now
    logger.info "[Session Expires At] #{session[:expires_at]}"
  end
  
  def session_expiry
    @session_expired = (session[:expires_at] - Time.now).to_i <= 0
    
    if @session_expired
      logger.info "[Session Expired] Redirecting to login. Expired at #{session[:expires_at]}"
      flash[:error] = "Session expired. Log back in to access the application."
      reset_session
      redirect_to '/login'
    end
  end
end
