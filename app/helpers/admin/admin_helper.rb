module Admin::AdminHelper
  def controller_options
    links = [
        content_tag(:li, link_to("New #{self.controller.controller_name.singularize.gsub(/_/,'-').humanize}", __send__("new_admin_#{self.controller.controller_name.singularize}_path")), :class => 'last')
      ].join
    content_tag(:ul, links, :class => "controller_options")
  end

  def navigation
    links = logged_in? ? [
      content_tag(:li, link_to_unless_current('Categories', admin_categories_path)),
      content_tag(:li, link_to_unless_current('Products', admin_products_path)),
      content_tag(:li, link_to_unless_current('Caresheets', admin_caresheets_path)),
      content_tag(:li, link_to_unless_current('Announcements', admin_announcements_path)),
      content_tag(:li, link_to_unless_current('Post Categories', admin_post_o_matic_categories_path)),
      content_tag(:li, link_to_unless_current('Post Postings', admin_post_o_matic_postings_path)),
      content_tag(:li, link_to_unless_current("Log out", logout_path))
    ] : []
    content_tag(:ul, links)
  end

  def render_flash_messages
    flash.each do |key,value|
      return content_tag(:p, value, :class => key.to_s)
    end
  end
end
