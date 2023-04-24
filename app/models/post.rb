class Post < ApplicationRecord
  enum mode: %i[global only_friend only_me], _default: :only_friend
  enum status: %i[pending passed], _default: :pending

  belongs_to :user
  belongs_to :group, required: false
  has_many :comments
  has_many :reactions, as: :ta_duty
  has_many :notifications, as: :ta_duty
  has_many :block_comments
  has_many :contents
  accepts_nested_attributes_for :contents, allow_destroy: true

  delegate :name, :avatar_url, :address, :birthday, to: :user, prefix: true

  paginates_per 3

  def self.ransackable_attributes(auth_object = nil)
    ["comment_flag", "content", "created_at", "group_id", "id", "mode", "status", "text", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["block_comments", "comments", "group", "notifications", "reactions", "user"]
  end

  def readable_users
    if only_me?
      [user_id]
    elsif only_friend?
      user.friends.pluck(:id).push(user_id)
    elsif group_id && pending?
      group.admins.pluck(:user_id).push(user_id)
    elsif group_id
      group.joiners.pluck(:user_id)
    else
      User.pluck(:id)
    end
  end
end
