class Notification < ApplicationRecord
  scope :viewed, -> { where(viewed: true) }
  scope :not_viewed, -> { where(viewed: false) }

  enum noti_type: %i[comment_post rep_comment reaction_post reaction_comment]

  belongs_to :user
  belongs_to :ta_duty, polymorphic: true

  paginates_per 3

  after_create_commit :add_real_time_noti

  def add_real_time_noti
    ActionCable.server.broadcast(
      "notification_#{user_id}",
      { new_noti_html: ApplicationController.render(partial: "notifications/item", locals: { noti: self }),
        count_noti: user.notifications.not_viewed.count }
    )
  end
end
