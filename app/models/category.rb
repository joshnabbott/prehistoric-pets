class Category < ActiveRecord::Base
  acts_as_list :scope => :parent_id
  acts_as_tree
end
