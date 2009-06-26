class Admin::CropsController < Admin::AdminController
  include PolyParent
  parent_resources :category, :product, :image
  # creates instance variables from parents stored in an array called @parents also sets @owner
  before_filter :set_poly_parents

  helper 'admin/jcrop'

  # GET /images/:image_id/crops
  # GET /images/:image_id/crops.xml
  def index
    @crops = @image.crops

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crops }
    end
  end

  # GET /images/:image_id/crops/1
  # GET /images/:image_id/crops/1.xml
  def show
    @crop = Crop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crop }
    end
  end

  # GET /images/:image_id/crops/new
  # GET /images/:image_id/crops/new.xml
  def new
    @crop = @image.crops.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @crop }
    end
  end

  # GET /images/:image_id/crops/1/edit
  def edit
    @crop = Crop.find(params[:id])
  end

  # POST /images/:image_id/crops
  # POST /images/:image_id/crops.xml
  def create
    @crop = @image.crops.build(params[:crop])

    respond_to do |format|
      if @crop.save
        flash[:success] = 'Crop was successfully created.'
        format.html { redirect_to([:admin, @parents, :crops]) }
        format.xml  { render :xml => @crop, :status => :created, :location => @crop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/:image_id/crops/1
  # PUT /images/:image_id/crops/1.xml
  def update
    @crop = Crop.find(params[:id])

    respond_to do |format|
      if @crop.update_attributes(params[:crop])
        flash[:success] = 'Crop was successfully updated.'
        format.html { redirect_to([:admin, @parents, :crops]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/:image_id/crops/1
  # DELETE /images/:image_id/crops/1.xml
  def destroy
    @crop = Crop.find(params[:id])
    @crop.destroy

    respond_to do |format|
      flash[:success] = 'Crop was successfully deleted.'
      format.html { redirect_to([:admin, @parents, :crops]) }
      format.xml  { head :ok }
    end
  end
end