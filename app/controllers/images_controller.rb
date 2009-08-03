class ImagesController < ApplicationController
  skip_before_filter :find_order
  caches_action :show, :if => Proc.new { |controller| controller.request.format.to_s =~ /image/ }

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.jpg   # show.jpg.flexi
      format.html # show.html.erb
      format.png # show.png.flexi
      format.xml  { render :xml => @image }
    end
  end
end
