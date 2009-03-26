module Prehistoric
  def to_param
    [id, permalink].join('-')
  end

private
  def create_permalink
    self.permalink = self.name.parameterize if self.name_changed?
  end
end