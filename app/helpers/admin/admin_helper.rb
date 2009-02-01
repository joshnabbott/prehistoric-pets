module Admin::AdminHelper
  def navigation
    links = logged_in? ? [
      content_tag(:li, link_to('Categories', admin_categories_path)),
      content_tag(:li, link_to('Products', admin_products_path)),
      content_tag(:li, link_to('Caresheets', admin_caresheets_path)),
      content_tag(:li, link_to('Announcements', admin_announcements_path)),
      content_tag(:li, link_to('Post-O-Matic Categories', admin_post_o_matic_categories_path)),
      content_tag(:li, link_to('Post-O-Matic Postings', admin_post_o_matic_postings_path)),
      content_tag(:li, link_to("Log out", logout_path))
    ] : []
    content_tag(:ul, links)
  end

  def render_flash_messages
    flash.each do |key,value|
      return content_tag(:p, value, :class => key.to_s)
    end
  end
end
