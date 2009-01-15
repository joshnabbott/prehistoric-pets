module Prehistoric
  def to_param
    [id, permalink].join('-')
  end

private
  def create_permalink
    self.permalink = self.name.to_permalink if self.name_changed?
  end
end