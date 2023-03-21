class Post < ApplicationRecord
  enum mode: %i[global only_friend only_me], _default: :only_friend
  enum status: %i[pending passed], _default: :pending

  belongs_to :user

  mount_uploader :content, PostFileUploader
end
