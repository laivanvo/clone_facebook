class Comment < ApplicationRecord
  enum level: %i[low medium high], _default: :low

  belongs_to :user
  belongs_to :post
  has_many :comments
  has_many :reactions, as: :ta_duty

  delegate :name, to: :user, prefix: true

  before_create :set_param_new

  mount_uploader :file, CommentFileUploader

  def set_param_new
    pre_comment = Comment.find_by(id: comment_id)
    return unless pre_comment

    self.level = Comment.levels.key(Comment.levels[pre_comment.level] + 1)
    self.post_id = pre_comment.post.id
  end
end
