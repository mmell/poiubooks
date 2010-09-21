module CommentsHelper

  def url_for_commentable(comment)
    controller.url_for_commentable(comment)
  end
  
  def display_votes(comment)
    counts = comment.count_vote_by_group
    diplay = "#{counts[true].to_i}/#{counts[false].to_i}<br />"
    if current_user and !comment.owner?(current_user)
      vote = Vote.find_by_user_id_and_comment_id(current_user.id, comment.id)
      if vote
        diplay += link_to_unless(vote.vote,
          image_tag("thumbs/up#{!vote.vote ? '_grey' : ''}.png", :border => 0, :size => '32x32'), 
            vote_on_comment_path(:id => comment.id, :thumbs => 'up'),
            {:method => :post}
          ) + link_to_unless(!vote.vote,
        image_tag("thumbs/down#{vote.vote ? '_grey' : ''}.png", :border => 0, :size => '32x32'),
          vote_on_comment_path(:id => comment.id, :thumbs => 'down'),
          {:method => :post}
        )
      else
        diplay += link_to(
        image_tag("thumbs/up.png", :border => 0, :size => '32x32'), 
          vote_on_comment_path(:id => comment.id, :thumbs => 'up'),
          {:method => :post}
        ) + link_to(
        image_tag("thumbs/down.png", :border => 0, :size => '32x32'),
          vote_on_comment_path(:id => comment.id, :thumbs => 'down'),
         {:method => :post}
        )
      end
    elsif comment.owner?(current_user)
      diplay += "#{link_to_if( comment.count_votes == 0, 'Edit', edit_comment_path(comment))} | 
			#{link_to( 'Destroy', comment, :confirm => 'Are you sure?', :method => :delete )}"
    end
    diplay
  end
  
end
