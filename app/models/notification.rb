class Notification < ApplicationRecord
  enum noti_type: %i[comment_post rep_comment]

  belongs_to :user
  belongs_to :ta_duty, -> { with_deleted }, polymorphic: true

  paginates_per 3
end
