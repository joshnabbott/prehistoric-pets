class Product < ActiveRecord::Base
  before_validation :create_permalink
  belongs_to :category
private
  def create_permalink
    self.permalink = self.name.to_permalink
  end
end