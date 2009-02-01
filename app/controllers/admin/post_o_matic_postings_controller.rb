class Admin::PostOMaticPostingsController < Admin::AdminController
  # GET /admin/post_o_matic_postings
  # GET /admin/post_o_matic_postings.xml
  def index
    if params[:post_o_matic_category_id]
      post_o_matic_category = PostOMaticCategory.find(params[:post_o_matic_category_id])
      @post_o_matic_postings = post_o_matic_category.post_o_matic_postings
    else
      @post_o_matic_postings = PostOMaticPosting.scheduled.find(:all, :order => 'position asc')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @post_o_matic_postings }
    end
  end

  # GET /admin/post_o_matic_postings/1
  # GET /admin/post_o_matic_postings/1.xml
  def show
    @post_o_matic_posting = PostOMaticPosting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post_o_matic_posting }
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
        flash[:notice] = 'PostOMaticPosting was successfully created.'
        format.html { redirect_to([:admin, @post_o_matic_posting]) }
        format.xml  { render :xml => @post_o_matic_posting, :status => :created, :location => @post_o_matic_posting }
      else
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
        flash[:notice] = 'PostOMaticPosting was successfully updated.'
        format.html { redirect_to([:admin, @post_o_matic_posting]) }
        format.xml  { head :ok }
      else
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
      format.html { redirect_to(admin_post_o_matic_postings_url) }
      format.xml  { head :ok }
    end
  end

  # Non-REST actions
  def update_positions
    # is this stupid?
    params[:post_o_matic_posting].each do |post_o_matic_posting|
      id       = post_o_matic_posting["id"]
      position = post_o_matic_posting["list_order"]
      record   = PostOMaticPosting.find(id)
      record.insert_at(position)
    end

    respond_to do |format|
      format.html { redirect_to(admin_post_o_matic_postings_url) }
      format.xml  { head :ok }
    end
  end
end
