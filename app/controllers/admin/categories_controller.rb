class Admin::CategoriesController < Admin::AdminController
  cache_sweeper :category_sweeper, :only => [ :create, :update, :destroy ]

  # GET /admin/categories
  # GET /admin/categories.xml
  def index
    @roots = Category.roots
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /admin/categories/new
  # GET /admin/categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /admin/categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /admin/categories
  # POST /admin/categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:success] = 'Category was successfully created.'
        format.html { redirect_to(admin_categories_url) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        flash[:error] = 'Category could not be created. See errors below.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/categories/1
  # PUT /admin/categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:success] = 'Category was successfully updated.'
        format.html { redirect_to(admin_categories_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Category could not be updated. Please see errors below.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      flash[:success] = 'Category was deleted.'
      format.html { redirect_to(admin_categories_url) }
      format.xml  { head :ok }
    end
  end

  def update_positions
    # params[:sortable] is an array of Category ids. ['1','2','3']
    if Category.update_positions(params[:sortable])
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end
end
