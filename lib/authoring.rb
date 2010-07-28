module Authoring

  def owner?(user = nil)
    user == owner
  end

  def owner
    self.user
  end

end