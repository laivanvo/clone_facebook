class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :ta_duty, polymorphic: true
  has_many :notifications, as: :ta_duty, dependent: :destroy_async

  delegate :name, :avatar_url, :address, :birthday, to: :user, prefix: true

  after_create_commit :add_noti

  def add_noti
    if user_id != ta_duty.user_id
      Notification.create user_id: ta_duty.user_id, ta_duty_id: id, ta_duty_type: :Reaction, noti_type: "reaction_#{ta_duty_type.downcase}"
    end
  end
end
