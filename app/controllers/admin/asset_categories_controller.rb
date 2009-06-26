class Admin::AssetCategoriesController < Admin::AdminController
  unloadable

  # GET /asset_categories
  # GET /asset_categories.xml
  def index
    @asset_categories = AssetCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asset_categories }
    end
  end

  # GET /asset_categories/1
  # GET /asset_categories/1.xml
  def show
    @asset_category = AssetCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset_category }
    end
  end

  # GET /asset_categories/new
  # GET /asset_categories/new.xml
  def new
    @asset_category = AssetCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset_category }
    end
  end

  # GET /asset_categories/1/edit
  def edit
    @asset_category = AssetCategory.find(params[:id])
  end

  # POST /asset_categories
  # POST /asset_categories.xml
  def create
    @asset_category = AssetCategory.new(params[:asset_category])

    respond_to do |format|
      if @asset_category.save
        flash[:success] = 'Asset category was successfully created.'
        format.html { redirect_to(admin_asset_categories_url) }
        format.xml  { render :xml => @asset_category, :status => :created, :location => @asset_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /asset_categories/1
  # PUT /asset_categories/1.xml
  def update
    @asset_category = AssetCategory.find(params[:id])

    respond_to do |format|
      if @asset_category.update_attributes(params[:asset_category])
        flash[:success] = 'Asset category was successfully updated.'
        format.html { redirect_to(admin_asset_categories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_categories/1
  # DELETE /asset_categories/1.xml
  def destroy
    @asset_category = AssetCategory.find(params[:id])
    @asset_category.destroy

    respond_to do |format|
      flash[:success] = 'Asset category was successfully deleted.'
      format.html { redirect_to(admin_asset_categories_url) }
      format.xml  { head :ok }
    end
  end
end
