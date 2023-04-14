module NotificationHelper
  def notification_redirect(notification)
    case notification.noti_type.to_sym
    when :comment_post, :rep_comment
      post_path(notification.ta_duty.post_id, current_comment_id: notification.ta_duty_id)
    end
  end
end
