class Post < ApplicationRecord
  enum mode: %i[global only_friend only_me], _default: :only_friend
  enum status: %i[pending passed], _default: :pending

  belongs_to :user
  has_many :comments
  has_many :reactions, as: :ta_duty
  has_many :block_comments

  delegate :name, to: :user, prefix: true

  mount_uploader :content, PostFileUploader
end
