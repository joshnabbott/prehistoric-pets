class PostOMaticPosting < ActiveRecord::Base
  include AASM
  # include PostOMatic::KingSnake
  acts_as_list :scope => 'state = \'scheduled\''
  before_validation :set_post_to, :set_post_in
  belongs_to :product
  validates_presence_of :product, :post_to, :post_in
  validates_inclusion_of :post_in, :in => [ 'adoptions', 'ball_pythons', 'pythons', 'tree_boas', 'boa_constrictors', 'other_boas', 'rose_rubber_and_sand_boas', 'new_world rat_snakes', 'old_world_rat_snakes', 'corn_snakes', 'gray_banded_kingsnakes', 'other_kings_and_milksnakes', 'other_snakes', 'venomous' ], :allow_nil => true, :message => '%s is not a valid category name.'

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
  def set_post_in
    self.post_in = self.product.category.name if self.post_in.blank?
  end

  def set_post_to
    self.post_to = 'kingsnake.com'
  end
end
