class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
