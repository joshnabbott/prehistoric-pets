class Announcement < ActiveRecord::Base
  include Prehistoric

  acts_as_fleximage do
    if RAILS_ENV == 'production'
      image_directory "../../shared/uploads/images"
    else
      image_directory 'public/images/uploads'
    end
    require_image false
    default_image_path 'public/images/smiley.gif'
    default_image 'smiley.gif'
  end

  default_scope :order => 'created_at desc'
  before_validation :create_permalink
  validates_presence_of :title_short, :body_short, :permalink
  validates_presence_of :title_long, :body_long, :if => :is_active?
  validates_uniqueness_of :title_short, :permalink, :allow_nil => true

  named_scope :active, :conditions => { :is_active => true }
  named_scope :featured, :conditions => { :is_featured => true }
private
  def is_active?
    is_active
  end

  def create_permalink
    self.permalink = self.title_short.to_permalink if self.title_short_changed?
  end
end
