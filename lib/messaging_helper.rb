module MessagingHelper
  
  def format_messages(arr, html_class, opts = {} )
    return '' if arr.empty?
    id = "#{html_class}_messages"
    s = "<div id='#{id}' class='#{html_class}'>"
    if 1 == arr.size
      s << arr[0]
    else
      s << '<ul><li>' << arr.join('</li><li>') << '</li></ul>' 
    end
    s << '</div>'
    if opts[:fade_delay_secs]
      s << %Q{
<script type='text/javascript'>
function fade_#{id}() { Effect.Fade('#{id}', { duration: 2 }); }
function fade_#{id}_delay() { setTimeout("fade_#{id}()", #{arr.size * opts[:fade_delay_secs] * 1000});}
fade_#{id}_delay();
</script>
}
    end
    s
  end
  
  def errors
    arr = flash[:error].nil? ? [] : [flash[:error]]
    arr += @errors_now unless @errors_now.nil?
    arr += flash[:errors] unless flash[:errors].nil?
    format_messages(arr, 'errors')
  end
  
  def alerts
    arr = flash[:alert].nil? ? [] : [flash[:alert]]
    arr += flash[:alerts] unless flash[:alerts].nil?
    arr += @alerts_now unless @alerts_now.nil?
    format_messages(arr, 'alerts')
  end

  def notices
    arr = flash[:notice].nil? ? [] : [flash[:notice]]
    arr += flash[:notices] unless flash[:notices].nil?
    arr += @notices_now unless @notices_now.nil?
    format_messages(arr, 'notices', :fade_delay_secs => 4)
  end
end
