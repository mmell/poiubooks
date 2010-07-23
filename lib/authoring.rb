module Authoring
  def owner?(user)
    self.user_id == user.id
  end

end