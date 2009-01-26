class PostOMaticPosting < ActiveRecord::Base
  include AASM
  # include PostOMatic::KingSnake
  acts_as_list :scope => 'state = \'scheduled\''
  before_validation :set_post_to
  belongs_to :product
  validates_presence_of :product, :post_to

  aasm_column :state
  aasm_initial_state :scheduled
  aasm_state :expired
  aasm_state :posted
  aasm_state :scheduled

  aasm_event :post_ad do
    transitions :to => :posted, :from => :scheduled
  end

  aasm_event :expire do
    transitions :to => :expired, :from => :posted
  end

  named_scope :expired,   :conditions => { :state => 'expired' }
  named_scope :posted,    :conditions => { :state => 'posted' }
  named_scope :scheduled, :conditions => { :state => 'scheduled' }

  # def post_ad
  #   post_ad!
  #   remove_from_list
  #   super
  # end
private
  def set_post_to
    self.post_to = 'kingsnake.com'
  end
end
