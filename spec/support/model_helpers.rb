module ModelHelpers
  def reset_db
    [ Book, Category, Chapter, Comment, License, Notification, SubChapter, User ].each { |e| 
      e.delete_all
    }
  end

end
