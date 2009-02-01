class Admin::PostOMaticCategoriesController < Admin::AdminController
  # GET /admin/post_o_matic_categories
  # GET /admin/post_o_matic_categories.xml
  def index
    @post_o_matic_categories = PostOMaticCategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @post_o_matic_categories }
    end
  end

  # GET /admin/post_o_matic_categories/1
  # GET /admin/post_o_matic_categories/1.xml
  def show
    @post_o_matic_category = PostOMaticCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post_o_matic_category }
    end
  end

  # GET /admin/post_o_matic_categories/new
  # GET /admin/post_o_matic_categories/new.xml
  def new
    @post_o_matic_category = PostOMaticCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post_o_matic_category }
    end
  end

  # GET /admin/post_o_matic_categories/1/edit
  def edit
    @post_o_matic_category = PostOMaticCategory.find(params[:id])
  end

  # POST /admin/post_o_matic_categories
  # POST /admin/post_o_matic_categories.xml
  def create
    @post_o_matic_category = PostOMaticCategory.new(params[:post_o_matic_category])

    respond_to do |format|
      if @post_o_matic_category.save
        flash[:notice] = 'PostOMaticCategory was successfully created.'
        format.html { redirect_to([:admin, @post_o_matic_category]) }
        format.xml  { render :xml => @post_o_matic_category, :status => :created, :location => @post_o_matic_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post_o_matic_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/post_o_matic_categories/1
  # PUT /admin/post_o_matic_categories/1.xml
  def update
    @post_o_matic_category = PostOMaticCategory.find(params[:id])

    respond_to do |format|
      if @post_o_matic_category.update_attributes(params[:post_o_matic_category])
        flash[:notice] = 'PostOMaticCategory was successfully updated.'
        format.html { redirect_to([:admin, @post_o_matic_category]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post_o_matic_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/post_o_matic_categories/1
  # DELETE /admin/post_o_matic_categories/1.xml
  def destroy
    @post_o_matic_category = PostOMaticCategory.find(params[:id])
    @post_o_matic_category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_post_o_matic_categories_url) }
      format.xml  { head :ok }
    end
  end
end
