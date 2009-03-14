class PostOMaticPosting < ActiveRecord::Base
  include AASM
  include PostOMatic::KingSnake

  # acts_as_list :scope => 'state = \'scheduled\''
  acts_as_list :scope => :post_o_matic_category_id
  default_scope :order => 'position asc'

  before_validation :set_post_to
  belongs_to :product
  belongs_to :post_o_matic_category
  validates_presence_of :product, :post_to, :ad_duration
  validates_inclusion_of :ad_duration, :in => [2, 7, 15, 30]

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
    # the post_ad method is defined in lib/post_o_matic.rb. the method creates a new listing on kingsnake.com
    # and returns true or false, depending on whether or not it was posted.
    # hence the 'super'
    is_posted = super
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
