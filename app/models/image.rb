class Image < Asset
  acts_as_fleximage do
    image_directory 'public/assets/images'
    require_image false
  end

  after_create :add_initial_crops_and_crop_definitions
  has_many :crops, :dependent => :destroy
  # validates_presence_of :asset_category

protected
  def add_initial_crops_and_crop_definitions
    crop_definitions = self.asset_categories.map(&:crop_definitions).flatten

    crop_definitions.each do |crop_definition|
      self.crops.create(
        :crop_definition => crop_definition,
        :width           => crop_definition.minimum_width,
        :height          => crop_definition.minimum_height,
        :x               => crop_definition.x,
        :y               => crop_definition.y
      )
    end
  end
end