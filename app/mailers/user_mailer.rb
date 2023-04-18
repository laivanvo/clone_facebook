class UserMailer < ApplicationMailer
  def notice_pending_post(admin_relation)
    @user = admin_relation.user
    @url = pending_posts_group_url(admin_relation.group_id)
    I18n.locale = @user.locale
    mail(to: @user.email)
  end
end
