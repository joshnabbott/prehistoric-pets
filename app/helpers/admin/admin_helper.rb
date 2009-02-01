module Admin::AdminHelper
  def navigation
    links = logged_in? ? [
      link_to('Categories', admin_categories_path),
      link_to('Products', admin_products_path),
      link_to('Caresheets', admin_caresheets_path),
      link_to('Announcements', admin_announcements_path),
      link_to('Post-O-Matic', admin_post_o_matic_postings_path),
      link_to("Log out", logout_path)
    ] : []
    links.join(' | ')
  end
end
