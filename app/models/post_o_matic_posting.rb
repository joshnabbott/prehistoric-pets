class PostOMaticPosting < ActiveRecord::Base
  include AASM
  default_scope :order => 'position asc'
  include PostOMatic::KingSnake
  # acts_as_list :scope => 'state = \'scheduled\''
  acts_as_list :scope => :post_o_matic_category_id
  before_validation :set_post_to
  belongs_to :product
  belongs_to :post_o_matic_category
  validates_presence_of :product, :post_to, :ad_duration

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

  def post_ad
    is_posted = super
    # is_posted = true
    if is_posted
      # post_ad!
      move_to_bottom
      time = Time.now
      set_expires_at(time)
      set_posted_at(time)
    end
    is_posted
  end
private
  def set_expires_at(time)
    self.expires_at = Time.now + self.ad_duration.days
  end

  def set_posted_at(time)
    self.posted_at = Time.now
  end

  def set_post_to
    self.post_to = 'kingsnake.com'
  end
end
