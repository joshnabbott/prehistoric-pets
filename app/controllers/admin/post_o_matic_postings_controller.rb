class Admin::PostOMaticPostingsController < Admin::AdminController
  before_filter :find_post_o_matic_category, :if => Proc.new { |controller| controller.params[:post_o_matic_category_id] }

  # GET /admin/post_o_matic_postings
  # GET /admin/post_o_matic_postings.xml
  def index
    if @post_o_matic_category
      @post_o_matic_postings = @post_o_matic_category.post_o_matic_postings
    else
      @post_o_matic_categories = PostOMaticCategory.find(:all, :include => :post_o_matic_postings)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @post_o_matic_postings }
    end
  end

  # GET /admin/post_o_matic_postings/new
  # GET /admin/post_o_matic_postings/new.xml
  def new
    @post_o_matic_posting = PostOMaticPosting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post_o_matic_posting }
    end
  end

  # GET /admin/post_o_matic_postings/1/edit
  def edit
    @post_o_matic_posting = PostOMaticPosting.find(params[:id])
  end

  # POST /admin/post_o_matic_postings
  # POST /admin/post_o_matic_postings.xml
  def create
    @post_o_matic_posting = PostOMaticPosting.new(params[:post_o_matic_posting])

    respond_to do |format|
      if @post_o_matic_posting.save
        flash[:success] = 'Post-O-Matic Posting was successfully created.'
        format.html { redirect_to(admin_post_o_matic_postings_url) }
        format.xml  { render :xml => @post_o_matic_posting, :status => :created, :location => @post_o_matic_posting }
      else
        flash[:error] = 'Post-O-Matic Posting could not be created. See errors below.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @post_o_matic_posting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/post_o_matic_postings/1
  # PUT /admin/post_o_matic_postings/1.xml
  def update
    @post_o_matic_posting = PostOMaticPosting.find(params[:id])

    respond_to do |format|
      if @post_o_matic_posting.update_attributes(params[:post_o_matic_posting])
        flash[:success] = 'Post-O-Matic Posting was successfully updated.'
        format.html { redirect_to(admin_post_o_matic_postings_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Post-O-Matic Posting could not be updated. See errors below.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post_o_matic_posting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/post_o_matic_postings/1
  # DELETE /admin/post_o_matic_postings/1.xml
  def destroy
    @post_o_matic_posting = PostOMaticPosting.find(params[:id])
    @post_o_matic_posting.destroy

    respond_to do |format|
      flash[:success] = 'Post-O-Matic Posting was deleted.'
      format.html { redirect_to(admin_post_o_matic_postings_url) }
      format.xml  { head :ok }
    end
  end

  def update_positions
    # params[:post_o_matic_postings] is an array of PostOMaticPosting ids. ['1','2','3']
    if PostOMaticPosting.update_positions(params[:post_o_matic_postings])
      render :nothing => true, :status => 200
    else
      render :nothing => true, :status => 500
    end
  end

protected
  def find_post_o_matic_category
    @post_o_matic_category = PostOMaticCategory.find_by_id(params[:post_o_matic_category_id])
  end
end
