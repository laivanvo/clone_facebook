class Post < ApplicationRecord
  belongs_to :user

  enum mode: %i[global only_friend only_me], _default: :only_friend

  mount_uploader :content, PostFileUploader
end
