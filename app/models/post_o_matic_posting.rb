class PostOMaticPosting < ActiveRecord::Base
  include AASM
  include PostOMatic::KingSnake

  # acts_as_list :scope => 'post_o_matic_category_id = #{post_o_matic_category_id} AND state = \'scheduled\''
  acts_as_list :scope => :post_o_matic_category
  default_scope :order => 'position asc'

  # Move to top of list
  after_create :move_to_top
  before_validation :set_post_to
  belongs_to :product
  belongs_to :post_o_matic_category
  validates_presence_of :post_to, :ad_duration
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

  aasm_event :schedule do
    transitions :to => :scheduled, :from => :posted
  end

  named_scope :expired,   :conditions => { :state => 'expired' }
  named_scope :posted,    :conditions => { :state => 'posted' }
  named_scope :scheduled, :conditions => { :state => 'scheduled' }

  # Methods to extend lib/post_o_matic funcionality
  def post_ad
    # the post_ad method is defined in lib/post_o_matic.rb. the method creates a new listing on kingsnake.com
    # and returns true or false, depending on whether or not it was posted.
    is_posted = super
    if is_posted
      update_posted_ad!
    end
    is_posted
  end

  def reschedule
    update_attributes(:expires_at => nil, :posted_at => nil)
    schedule! unless scheduled?
    insert_at(position)
  end

  def self.update_positions(*positions)
    # positions is an array of PostOMaticPosting ids. => ['1','2','3']
    # it can be passed in either way:
    # PostOMaticPosting.update_positions(['1','2','3'])
    # PostOMaticPosting.update_positions(1,2,3)
    # Just use Array#flatten to turn this: [['1','2','3']] (when an array is passed in)
    # to this: ['1','2','3']
    positions = positions.flatten
    # Removes blank items from array (jQuery is passing back an empty value for one array item)
    positions.delete_if { |item| item.blank? }
    positions.each_with_index do |id, index|
      position = index + 1
      self.update(id, :position => position)
    end
  end

private
  def set_expires_at(time)
    self.expires_at = time + self.ad_duration.days
  end

  def set_posted_at(time)
    self.posted_at = time
  end

  def set_post_to
    self.post_to = 'kingsnake.com'
  end

  def update_posted_ad!
    self.post_ad!
    time = Time.now
    set_expires_at(time)
    set_posted_at(time)
    self.save!
  end
end
