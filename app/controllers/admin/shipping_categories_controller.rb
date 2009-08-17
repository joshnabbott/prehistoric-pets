class Admin::ShippingCategoriesController < Admin::AdminController
  # GET /admin/shipping_categories
  # GET /admin/shipping_categories.xml
  def index
    @shipping_categories = ShippingCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipping_categories }
    end
  end

  # GET /admin/shipping_categories/1
  # GET /admin/shipping_categories/1.xml
  def show
    @shipping_category = ShippingCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping_category }
    end
  end

  # GET /admin/shipping_categories/new
  # GET /admin/shipping_categories/new.xml
  def new
    @shipping_category = ShippingCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_category }
    end
  end

  # GET /admin/shipping_categories/1/edit
  def edit
    @shipping_category = ShippingCategory.find(params[:id])
  end

  # POST /admin/shipping_categories
  # POST /admin/shipping_categories.xml
  def create
    @shipping_category = ShippingCategory.new(params[:shipping_category])

    respond_to do |format|
      if @shipping_category.save
        flash[:success] = 'Shipping category was successfully created.'
        format.html { redirect_to(admin_shipping_categories_url) }
        format.xml  { render :xml => @shipping_category, :status => :created, :location => @shipping_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/shipping_categories/1
  # PUT /admin/shipping_categories/1.xml
  def update
    @shipping_category = ShippingCategory.find(params[:id])

    respond_to do |format|
      if @shipping_category.update_attributes(params[:shipping_category])
        flash[:success] = 'Shipping  ategory was successfully updated.'
        format.html { redirect_to(admin_shipping_categories_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/shipping_categories/1
  # DELETE /admin/shipping_categories/1.xml
  def destroy
    @shipping_category = ShippingCategory.find(params[:id])
    @shipping_category.destroy

    respond_to do |format|
      flash[:success] = 'Shipping category was deleted.'
      format.html { redirect_to(admin_shipping_categories_url) }
      format.xml  { head :ok }
    end
  end
end
