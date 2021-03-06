class Admin::AnnouncementsController < Admin::AdminController
  cache_sweeper :announcement_sweeper, :only => [ :create, :update, :destroy ]

  # GET /admin/announcements
  # GET /admin/announcements.xml
  def index
    @announcements = Announcement.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @announcements }
    end
  end

  # GET /admin/announcements/new
  # GET /admin/announcements/new.xml
  def new
    @announcement = Announcement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @announcement }
    end
  end

  # GET /admin/announcements/1/edit
  def edit
    @announcement = Announcement.find(params[:id])
  end

  # POST /admin/announcements
  # POST /admin/announcements.xml
  def create
    @announcement = Announcement.new(params[:announcement])

    respond_to do |format|
      if @announcement.save
        flash[:success] = 'Announcement was successfully created.'
        format.html { redirect_to(admin_announcements_url) }
        format.xml  { render :xml => @announcement, :status => :created, :location => @announcement }
      else
        flash[:error] = 'Announcement could not be created. See errors below.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/announcements/1
  # PUT /admin/announcements/1.xml
  def update
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.update_attributes(params[:announcement])
        flash[:success] = 'Announcement was successfully updated.'
        format.html { redirect_to(admin_announcements_url) }
        format.xml  { head :ok }
      else
        flash[:error] = 'Announcement could not be created. See errors below.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @announcement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/announcements/1
  # DELETE /admin/announcements/1.xml
  def destroy
    @announcement = Announcement.find(params[:id])
    @announcement.destroy

    respond_to do |format|
      flash[:success] = 'Announcement was deleted.'
      format.html { redirect_to(admin_announcements_url) }
      format.xml  { head :ok }
    end
  end
end
