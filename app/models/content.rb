class Content < ApplicationRecord
  belongs_to :post
  has_many :comments
  has_many :reactions, as: :ta_duty, dependent: :destroy_async

  delegate :user_id, to: :post

  mount_uploader :file, ContentFileUploader
end
