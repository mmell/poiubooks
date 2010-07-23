module Authoring

  def owner?(user = nil)
    user and self.user_id == user.id
  end

end