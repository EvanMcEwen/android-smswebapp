class SynchashesController < ApplicationController
  skip_before_filter :ensure_user_logged_in, :only => [:create, :update]
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
        newIn = !synchash.in_hash.eql?(params[:in_hash]) if !params[:in_hash].eql?("empty")
        newOut = !synchash.out_hash.eql?(params[:out_hash]) if !params[:out_hash].eql?("empty")
        render_output(synchash,newIn,newOut)
      else
        synchash = Synchash.new
        synchash.in_hash = "empty"
        synchash.out_hash = "empty"
        synchash.user = user
        synchash.save
        render_output(synchash,true,true)
      end
    end
  end

  # PUT /synchashes/1
  # PUT /synchashes/1.json
  def update
    user = User.find_by_username(params[:username])
    synchash = user.synchash

    if !synchash.nil?
      synchash.in_hash = params[:in_hash] if params[:in_status]
      synchash.out_hash = params[:out_hash] if params[:out_status]
    else
      synchash = Synchash.new
      synchash.in_hash = "empty"
      synchash.out_hash = "empty"
      synchash.in_hash = params[:in_hash] if params[:in_status]
      synchash.out_hash = params[:out_hash] if params[:out_status]
      synchash.user = user
    end
    if (synchash.save)
      render :json => {:status => 1}
    else
      render :json => {:status => 0}
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
  def render_output(synchash,newIn,newOut)
    if (newIn || newOut)
      render :json => {:sync_status => 1, :new_in_status => newIn, :new_out_status => newOut, :in_hash => synchash.in_hash, :out_hash => synchash.out_hash}
    else
      render :json => {:sync_status => 0}
    end
  end
end
