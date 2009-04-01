module Admin::AdminHelper
  def sub_navigation(*args)
    links = args.inject([]) do |array, arg|
      array << content_tag(:li, link_to(arg.first, arg.last), :class => "#{args.last.eql?(arg) ? 'last' : ''}")
      array
    end.join
    content_tag(:ul, links, :class => "sub_navigation")
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
