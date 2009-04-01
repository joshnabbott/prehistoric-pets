class Admin::ProductsController < Admin::AdminController
  before_filter :find_category, :if => Proc.new { |controller| controller.params[:category_id] }

  cache_sweeper :product_sweeper, :only => [ :create, :update, :destroy ]

  # GET /admin/products
  # GET /admin/products.xml
  def index
    if @category
      @products = @category.products
    else
      @products = Product.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /admin/products/new
  # GET /admin/products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /admin/products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /admin/products
  # POST /admin/products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:success] = 'Product was successfully created.'
        # What the hackery?
        format.html { redirect_to(@category ? admin_category_products_url : admin_products_url) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        flash[:error] = 'Product could not be created. See errors below.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  # PUT /admin/products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:success] = 'Product was successfully updated.'
        # What the hackery?
        format.html { redirect_to(@category ? admin_category_products_url : admin_products_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Category could not be created. See errors below.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      flash[:success] = 'Product was deleted.'
      # What the hackery?
      format.html { redirect_to(@category ? admin_category_products_url : admin_products_url) }
      format.xml  { head :ok }
    end
  end

protected
  def find_category
    @category = Category.find(params[:category_id])
  end
end
