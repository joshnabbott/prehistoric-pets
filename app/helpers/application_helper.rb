# Methods added to this helper will be available to all templates in the application.
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

  def categories_nested_for_select(categories = Category.roots, level = 0, &block)
    if categories.size > 0
      categories.inject(String.new) do |string,category|
        @indent = level == 0 ? '' : '-' * level
        next if category.parent_id && level == 0
        string.concat(yield(category))
        string.concat(categories_nested_for_list(category.children, level + 1, &block)) unless category.children.empty?
        string
      end
    end
  end
end