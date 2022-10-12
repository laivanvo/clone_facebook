class Post < ApplicationRecord
  belongs_to :user

  enum mode: [:public, :only_friend, :only_me]
end
