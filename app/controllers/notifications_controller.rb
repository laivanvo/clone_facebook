class NotificationsController < ApplicationController
  include NotificationHelper
  skip_before_action :verify_authenticity_token, only: %i[view]

  def index
    @notis = current_user.notifications.page(params[:page]).per(5)
  end

  def view
    @noti = current_user.notifications.not_viewed.find_by(id: params[:id])
    if @noti.nil?
      return redirect_to not_permission_path
    end
    @noti.viewed = true
    if @noti.save
      redirect_to notification_redirect(@noti)
    else
      redirect_to not_permission_path
    end
  end

  def view_all
    @notis = current_user.notifications
    if @notis.update view: true
      render :view_all
    else
      redirect_to not_permission_path
    end
  end
end
