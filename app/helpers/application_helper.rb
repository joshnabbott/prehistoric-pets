module ApplicationHelper
  def categories_nested_for_list(categories = Category.roots, level = 0, &block)
    if categories.size > 0
      categories.inject(String.new) do |string,category|
        next if category.parent_id && level == 0
        string.concat(yield(category))
        string.concat(content_tag(:ul, categories_nested_for_list(category.children, level + 1, &block))) unless category.children.empty?
        string
      end
    end
  end

  def category_active_state(category)
    if @product
      active_state = 'active' if @product.categories.include?(category) # || @product.categories.map(&:ancestors).include?(category)
    elsif params[:categories]
      active_state = 'active' if params[:categories].include?(category.permalink)
    end
    active_state
  end
end