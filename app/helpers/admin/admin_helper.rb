module Admin::AdminHelper
  def navigation
    links = logged_in? ? [
      link_to('Categories', admin_categories_path),
      link_to('Products', admin_products_path),
      link_to("Log out", logout_path)
    ] : []
    links.join(' | ')
  end
end
