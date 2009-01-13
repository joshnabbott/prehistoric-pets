class Caresheet < ActiveRecord::Base
  before_validation :create_permalink
  has_many :products, :dependent => :nullify
private
  def create_permalink
    self.permalink = self.name.to_permalink
  end
end