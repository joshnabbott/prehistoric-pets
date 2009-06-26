module Admin::AdminHelper
  def navigation
    links = current_user ? [
        # content_tag(:li, link_to_unless_current('Asset Categories', asset_categories_path)),
        # content_tag(:li, link_to_unless_current('Availabilities', availabilities_path)),
        # content_tag(:li, link_to_unless_current('Color Grids', color_grids_path)),
        # content_tag(:li, link_to_unless_current('Crop Definitions', crop_definitions_path)),
        # content_tag(:li, link_to_unless_current('Key/Value Pairs', key_value_pairs_path)),
        # content_tag(:li, link_to_unless_current('Overlays', overlays_path)),
        # content_tag(:li, link_to_unless_current('Size Grids', size_grids_path)),
        # content_tag(:li, link_to_unless_current('My account', account_path)),
        # content_tag(:li, link_to_unless_current('Log out', user_session_path, :method => :delete, :confirm => 'Are you sure you want to log out?')),
      ] : []
      content_tag(:ul, links, :id => 'navigation')
  end

  def nested_as_options(acts_as_tree_set, level = 0, &block)
    if acts_as_tree_set.size > 0
      @array = acts_as_tree_set.inject(@array ||= []) do |array, record|
        @indent = level == 0 ? '' : '-' * level
        next if record.parent_id && level == 0
        array << yield(record)
        nested_as_options(record.children, level + 1, &block) unless record.children.empty?
        array
      end
    end
  end

  # Used to create a select tag with options displayed in their nested heirarchy.
  # Works in conjunction with an acts_as_tree set (good for categories, or other nested sets)
  # Accepts all the same parameters as <tt>select</tt>.
  # For more information, see the <tt>nested_as_options</tt> method.
  def nested_select(object, method, collection, options = {}, html_options = {})
    choices = nested_as_options(collection) { |record| ["#{@indent} #{record.name}", record.id] }
    select(object, method, choices, options, html_options)
  end

  def sub_navigation(*args)
    links = args.inject([]) do |array, arg|
      array << content_tag(:li, link_to(arg.first, arg.last), :class => "#{args.last.eql?(arg) ? 'last' : ''}")
      array
    end.join
    content_tag(:ul, links, :class => "sub_navigation")
  end

  def stylesheet_for_controller
    stylesheet_name = "_#{@controller.controller_name.downcase}"
    stylesheet_link_tag(stylesheet_name) if File.exists?("#{RAILS_ROOT}/public/stylesheets/#{stylesheet_name}.css")
  end

  def tabbed_navigation
    links = logged_in? ? [
      content_tag(:li, link_to_unless_current('Categories', admin_categories_path)),
      # content_tag(:li, link_to_unless_current('Products', admin_products_path)),
      content_tag(:li, link_to_unless_current('Caresheets', admin_caresheets_path)),
      content_tag(:li, link_to_unless_current('Announcements', admin_announcements_path)),
      content_tag(:li, link_to_unless_current('Post Categories', admin_post_o_matic_categories_path)),
      content_tag(:li, link_to_unless_current('Post Postings', admin_post_o_matic_postings_path)),
      content_tag(:li, link_to_unless_current("Log out", logout_path))
    ] : []
    content_tag(:ul, links, :id => 'tabbed_navigation')
  end

  def render_flash_messages
    flash.each do |key,value|
      return content_tag(:p, value, :class => key.to_s)
    end
  end
end
