class DeviceController < ApplicationController
	skip_before_filter :ensure_user_logged_in
  
  def create
    @device = Device.new
    @device.device_id = params[:device][:device_id]
    @device.reg_id = params[:device][:reg_id]
    @device.user = User.find_by_username(params[:device][:username])
    @device.nickname = params[:device][:nickname]
    
    respond_to do |format|
      if @device.save
        format.json { render :json => @device, :status => :created, :location => @device }
      else
        format.json { render :json => @device.errors, :status => :unprocessable_entity }
      end
    end
  end
end