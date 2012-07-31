class MessagesController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:create]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.find_all_by_user_id(session[:user_id], :order => "timestamp DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    respond_to do |format|
      format.html {
        @messages = Message.find_all_by_user_id(session[:user_id], :conditions => ["origin=? OR destination=?",params[:id],params[:id]], :order => "timestamp ASC")
        render :layout => false
      }# show.html.erb
      format.json { 
        @message = Message.find(params[:id])
        render :json => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    if (params.has_key?(:total_in_messages) || params.has_key?(:total_out_messages))
      if (params.has_key?(:total_in_messages))
        i = 0
        while i < params[:total_in_messages] do
          message = Message.new()
          phoneNum = params[:in_messages]["sms" + i.to_s][:number].gsub(/[^0-9]/i, '')
          phoneNum.slice!(0) if (phoneNum.size != 10)
          message.origin = phoneNum
          message.destination = "DEVICE"
          message.timestamp = params[:in_messages]["sms" + i.to_s][:timestamp]
          message.message = params[:in_messages]["sms" + i.to_s][:message]
          message.user = User.find_by_username(params[:username])
          message.save
          i += 1
        end
      end
      if (params.has_key?(:total_out_messages))
        i = 0
        while i < params[:total_out_messages] do
          message = Message.new()
          phoneNum = params[:out_messages]["sms" + i.to_s][:number].gsub(/[^0-9]/i, '')
          phoneNum.slice!(0) if (phoneNum.size != 10)
          message.origin = "DEVICE"
          message.destination = phoneNum
          message.timestamp = params[:out_messages]["sms" + i.to_s][:timestamp]
          message.message = params[:out_messages]["sms" + i.to_s][:message]
          message.user = User.find_by_username(params[:username])
          message.save
          i += 1
        end
      end
      render :json => {:status => "1"}, :status => :created
    else
      @message = Message.new()
      phoneNum = params[:origin].gsub(/[^0-9]/i, '')
      phoneNum.slice!(0) if (phoneNum.size != 10)
      @message.origin = phoneNum
      @message.message = params[:message]
      @message.timestamp = params[:timestamp]
      @message.user = User.find_by_username(params[:username])
      @message.destination = params[:destination]

      if @message.save
        render :json => {:status => "1"}, :status => :created
      else
        render :json => {:status => "0"}, :status => :unprocessable_entity
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, :notice => 'Message was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :ok }
    end
  end
end
