import consumer from "./consumer"

consumer.subscriptions.create( "NotificationChannel" , {
  received(data) {
    $(data.new_noti_html).insertBefore($("#new_noti"))
    $("#count_noti").html(data.count_noti)
  }
});
