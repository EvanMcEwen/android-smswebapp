class SynchashesController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:create]
  # GET /synchashes
  # GET /synchashes.json
  def index
    @synchashes = Synchash.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @synchashes }
    end
  end

  # GET /synchashes/1
  # GET /synchashes/1.json
  def show
    @synchash = Synchash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @synchash }
    end
  end

  # GET /synchashes/new
  # GET /synchashes/new.json
  def new
    @synchash = Synchash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @synchash }
    end
  end

  # GET /synchashes/1/edit
  def edit
    @synchash = Synchash.find(params[:id])
  end

  # POST /synchashes
  # POST /synchashes.json
  def create
    user = User.find_by_username(params[:username])
    newIn = false;
    newOut = false;

    if !user.nil?
      synchash = user.synchash
      if !synchash.nil?
        newIn = true if synchash.in_hash != params[:in_hash]
        newOut = true if synchash.out_hash != params[:out_hash]
        notify_push_user(synchash,newIn,newOut)
      else
        synchash = Synchash.new
        synchash.in_hash = params[:in_hash]
        synchash.out_hash = params[:out_hash]
        synchash.user = user
        synchash.save
        notify_push_user(synchash,true,true)
      end
    end
  end

  # PUT /synchashes/1
  # PUT /synchashes/1.json
  def update
    @synchash = Synchash.find(params[:id])

    respond_to do |format|
      if @synchash.update_attributes(params[:synchash])
        format.html { redirect_to @synchash, :notice => 'Synchash was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @synchash.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /synchashes/1
  # DELETE /synchashes/1.json
  def destroy
    @synchash = Synchash.find(params[:id])
    @synchash.destroy

    respond_to do |format|
      format.html { redirect_to synchashes_url }
      format.json { head :ok }
    end
  end

  private
  def notify_push_user(synchash,newIn,newOut)
    if (newIn || newOut)
      C2DM.authenticate!("sdnotifications@gmail.com", "GlazingPutty", "smswebapp")
      c2dm = C2DM.new

      notification = {
        :registration_id => synchash.user.devices[0].reg_id, 
        :data => {
          :action => "SMS_SYNC_STATUS",
          :in_status => newIn,
          :out_status => newOut,
          :in_hash => synchash.in_hash,
          :out_hash => synchash.out_hash
        },
        :collapse_key => "smssync" #optional
      }

      c2dm.send_notification(notification)
    end
  end
end
