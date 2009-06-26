class Admin::ImagesController < Admin::AdminController
  # Cache the images for quicker rendering
  caches_page :show, :if => Proc.new { |controller| controller.request.format.to_s =~ /image/ }
  cache_sweeper :image_sweeper, :only => [:create, :update, :destroy]
  skip_before_filter :login_required, :only => [:swfupload]

  include PolyParent
  parent_resources :category, :product
  # creates instance variables from parents stored in an array called @parents
  # also sets @owner
  before_filter :set_poly_parents
  protect_from_forgery :except => :swfupload

  # GET /images
  # GET /images.xml
  def index
    @images = @owner.images

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.jpg   # show.jpg.flexi
      format.html # show.html.erb
      format.png # show.png.flexi
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = @owner.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image = @owner.images.build(params[:image])

    respond_to do |format|
      if @image.save
        flash[:success] = 'Image was successfully created.'
        format.html { redirect_to([:admin, @parents, :images]) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:success] = 'Image was successfully updated.'
        format.html { redirect_to([:admin, @parents, :images]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      flash[:success] = 'Image was successfully deleted.'
      format.html { redirect_to([:admin, @parents, :images]) }
      format.xml  { head :ok }
    end
  end

  def swfupload
    # SWFUpload file
    if params[:Filedata]
      image_params = { :image_file => params[:Filedata], :name => params[:Filename] }
      image_params.update(params[:image]) if params[:image]

      @owner.images.build(image_params)
      if @owner.save
        render :text => 'Success'
      else
        render :text => 'Error'
      end
    else
      # Standard upload
      @owner.images.build(params[:image])
      if @owner.save
        flash[:success] = 'Your image has been uploaded!'
        redirect_to([:admin, @parents, :images])
      else
        render :action => :new
      end
    end
  end
end
