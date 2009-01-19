class ImagesController < Admin::AdminController
  # GET /admin/images
  # GET /admin/images.xml
  def index
    @images = Image.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /admin/images/1
  # GET /admin/images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/images/new
  # GET /admin/images/new.xml
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /admin/images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /admin/images
  # POST /admin/images.xml
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        flash[:notice] = 'Image was successfully created.'
        format.html { redirect_to([:admin, @image]) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/images/1
  # PUT /admin/images/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to([:admin, @image]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/images/1
  # DELETE /admin/images/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_images_url) }
      format.xml  { head :ok }
    end
  end
end
