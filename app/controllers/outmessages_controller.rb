class OutmessagesController < ApplicationController
skip_before_filter :ensure_user_logged_in, :only => [:create, :show]
  # GET /outmessages
  # GET /outmessages.json
  def index
    @outmessages = Outmessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @outmessages }
    end
  end

  # GET /outmessages/1
  # GET /outmessages/1.json
  def show
    @outmessage = Outmessage.find(params[:id])
    render :json => @outmessage

    message = Message.new
    message.origin = "DEVICE"
    message.message = @outmessage.message
    message.timestamp = @outmessage.timestamp
    message.user = @outmessage.user
    message.destination = @outmessage.destination
    message.save

    @outmessage.destroy
  end

  # GET /outmessages/new
  # GET /outmessages/new.json
  def new
    @outmessage = Outmessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @outmessage }
    end
  end

  # GET /outmessages/1/edit
  def edit
    @outmessage = Outmessage.find(params[:id])
  end

  # POST /outmessages
  # POST /outmessages.json
  def create
    @outmessage = Outmessage.new
    @outmessage.destination = params[:outmessage][:destination]
    @outmessage.message = params[:outmessage][:message]
    @outmessage.timestamp = Time.now.to_f*1000
    @outmessage.user = User.find_by_username(session[:user_id].username)

    if @outmessage.save
        notify_push_user(@outmessage)
  end

  # PUT /outmessages/1
  # PUT /outmessages/1.json
  def update
    @outmessage = Outmessage.find(params[:id])

    respond_to do |format|
      if @outmessage.update_attributes(params[:outmessage])
        format.html { redirect_to @outmessage, :notice => 'Outmessage was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @outmessage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outmessages/1
  # DELETE /outmessages/1.json
  def destroy
    @outmessage = Outmessage.find(params[:id])
    @outmessage.destroy

    respond_to do |format|
      format.html { redirect_to outmessages_url }
      format.json { head :ok }
    end
  end

  private
  def notify_push_user(outmessage)
    C2DM.authenticate!("sdnotifications@gmail.com", "GlazingPutty", "smswebapp")
    c2dm = C2DM.new

    notification = {
      :registration_id => session[:user_id].devices[0].reg_id, 
      :data => {
        :action => "NEW_SMS_TO_SEND",
        :msg_id => outmessage.id
      },
      :collapse_key => "newsms" #optional
    }

    c2dm.send_notification(notification)
  end
end
