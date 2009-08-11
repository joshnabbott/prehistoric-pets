class SearchController < ApplicationController
  def index
    # Search form posts by default, at which point we'll intercept the request and build a prettier
    # URL with the keywords. With :get the url looks something like /search?keywords=searchterm&commit=Submit
    # We just want /search/search+term
    if request.post?
      redirect_to search_path(CGI::escape(params[:keywords]))
      return
    end

    @products = Product.search(params[:keywords], :with => { :is_active => true }, :match_mode => :boolean)
    # Tmp hack to only show active products
    @products = @products.select { |product| product.can_display? }
  end
end
