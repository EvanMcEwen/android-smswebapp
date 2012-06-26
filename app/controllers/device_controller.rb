class DevicesController < ApplicationController
	skip_before_filter :ensure_user_logged_in, :session_expiry, :update_session_expiry
  
  def create
    @device = Device.find_or_create_by_device_id(params[:device_id])
    @device.device_id = params[:device_id]
    @device.reg_id = params[:reg_id]
    @device.user = User.find_by_username(params[:username])
    @device.nickname = params[:nickname]
    
    if @device.save
      render :json => {:status => "1" }, :status => :created
    else
      render :json => @device.errors, :status => :unprocessable_entity
    end
  end
end