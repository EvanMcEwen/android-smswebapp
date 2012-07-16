class SynchashesController < ApplicationController
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
    @synchash = Synchash.new(params[:synchash])

    respond_to do |format|
      if @synchash.save
        format.html { redirect_to @synchash, :notice => 'Synchash was successfully created.' }
        format.json { render :json => @synchash, :status => :created, :location => @synchash }
      else
        format.html { render :action => "new" }
        format.json { render :json => @synchash.errors, :status => :unprocessable_entity }
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
end
