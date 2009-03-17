# == Schema Information
# Schema version: 20090302034918
#
# Table name: taxons
#
#  id          :integer(4)      not null, primary key
#  category_id :integer(4)
#  product_id  :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Taxon < ActiveRecord::Base
  belongs_to :category
  belongs_to :product
end
