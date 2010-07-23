module CommentsHelper
  def display_vote(comment)
    if comment.commentable.owner?(current_user)
      case comment.vote
      when nil 
          link_to(
            image_tag('thumbs_up.png', :border => 0), 
              {:controller => :comments, :action => :vote, :id => comment.id, :thumbs => 'up'},
              {:method => :post}
          ) + link_to(
            image_tag('thumbs_down.png', :border => 0), 
              {:controller => :comments, :action => :vote, :id => comment.id, :thumbs => 'down'}, 
              {:method => :post}
          )
      when true
        link_to(image_tag('thumbs_up.png', :border => 0),
          {:controller => :comments, :action => :vote, :id => comment.id}, 
          {:method => :post}
        )
      when false
        link_to(image_tag('thumbs_down.png', :border => 0), 
          {:controller => :comments, :action => :vote, :id => comment.id}, 
          {:method => :post}
        )
      end
    else
      case comment.vote
      when nil 
        '&#8212;'
      when true
        image_tag('thumbs_up.png')
      when false
        image_tag('thumbs_down.png')
      end
    end
  end
  
end
