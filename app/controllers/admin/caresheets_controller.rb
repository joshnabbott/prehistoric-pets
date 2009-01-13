class Admin::CaresheetsController < Admin::AdminController
  # GET /admin/caresheets
  # GET /admin/caresheets.xml
  def index
    @caresheets = Caresheet.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @caresheets }
    end
  end

  # GET /admin/caresheets/1
  # GET /admin/caresheets/1.xml
  def show
    @caresheet = Caresheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @caresheet }
    end
  end

  # GET /admin/caresheets/new
  # GET /admin/caresheets/new.xml
  def new
    @caresheet = Caresheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @caresheet }
    end
  end

  # GET /admin/caresheets/1/edit
  def edit
    @caresheet = Caresheet.find(params[:id])
  end

  # POST /admin/caresheets
  # POST /admin/caresheets.xml
  def create
    @caresheet = Caresheet.new(params[:caresheet])

    respond_to do |format|
      if @caresheet.save
        flash[:notice] = 'Caresheet was successfully created.'
        format.html { redirect_to([:admin, @caresheet]) }
        format.xml  { render :xml => @caresheet, :status => :created, :location => @caresheet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @caresheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/caresheets/1
  # PUT /admin/caresheets/1.xml
  def update
    @caresheet = Caresheet.find(params[:id])

    respond_to do |format|
      if @caresheet.update_attributes(params[:caresheet])
        flash[:notice] = 'Caresheet was successfully updated.'
        format.html { redirect_to([:admin, @caresheet]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @caresheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/caresheets/1
  # DELETE /admin/caresheets/1.xml
  def destroy
    @caresheet = Caresheet.find(params[:id])
    @caresheet.destroy

    respond_to do |format|
      format.html { redirect_to(admin_caresheets_url) }
      format.xml  { head :ok }
    end
  end
end
