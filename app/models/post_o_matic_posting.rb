class PostOMaticPosting < ActiveRecord::Base
  include AASM
  include PostOMatic::KingSnake
  acts_as_list
  before_validation :set_posted_to
  belongs_to :product
  validates_presence_of :product, :posted_to

  aasm_column :state
  aasm_initial_state :scheduled
  aasm_state :posted

  aasm_event :post_ad do
    transitions :to => :posted, :from => :scheduled
  end
private
  def set_posted_to
    self.posted_to = 'kingsnake.com'
  end
end
