module Messaging

  def error_messages_empty?
    [flash[:errors], @errors_now].each { |e| 
      return false if (!defined?(e) or e.nil? or e.size == 0)
    }
  end

  def error_message_now( *msg )
    @errors_now ||= []
    @errors_now += msg
  end

  def alert_message_now( *msg )
    @alerts_now ||= []
    @alerts_now += msg
  end

  def notice_message_now( *msg )
    @notices_now ||= []
    @notices_now += msg
  end

  def error_message( *msg )
    flash[:errors] ||= []
    flash[:errors] += msg
  end

  def alert_message( *msg )
    flash[:alerts] ||= []
    flash[:alerts] += msg
  end

  def notice_message( *msg )
    flash[:notices] ||= []
    flash[:notices] += msg
  end

end
