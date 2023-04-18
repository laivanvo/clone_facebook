class Comment < ApplicationRecord
  enum level: %i[low medium high], _default: :low

  belongs_to :user
  belongs_to :post
  has_many :comments
  has_many :reactions, as: :ta_duty, dependent: :destroy_async
  has_many :notifications, as: :ta_duty, dependent: :destroy_async

  validates :text, presence: true
  validate :wrong_reply

  delegate :name, :avatar_url, :address, :birthday, to: :user, prefix: true
  delegate :comment_flag, to: :post, prefix: true

  before_create :set_param_new
  after_create_commit :add_noti

  paginates_per 3

  mount_uploader :file, CommentFileUploader

  def parent_comment
    Comment.find_by(id: comment_id)
  end

  def content
    Content.find_by(id: content_id)
  end

  def set_param_new
    pre_comment = Comment.find_by(id: comment_id)
    return unless pre_comment

    self.level = Comment.levels.key(Comment.levels[pre_comment.level] + 1)
    self.post_id = pre_comment.post.id
  end

  def wrong_reply
    errors.add(:comment_id, :wrong) if (comment_id && comment_id == id)
  end

  def add_noti
    if user_id != post.user_id
      Notification.create user_id: post.user_id, ta_duty_id: id, ta_duty_type: :Comment, noti_type: :comment_post
    end
    unless low?
      if user_id != parent_comment.user_id
        Notification.create user_id: parent_comment.user_id, ta_duty_id: id, ta_duty_type: :Comment, noti_type: :rep_comment
      end
    end
  end

  def low_comment
    if low?
      self
    elsif parent_comment.nil?
      nil
    else
      parent_comment.low_comment
    end
  end
end
