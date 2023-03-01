class Relation < ApplicationRecord
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'

  enum relation_type: %i[requested friend], _default: :requested

  before_validation :add

  validate :cannot_add_self

  validates :arr, uniqueness: { message: "đã gửi lời mời kết bạn trước đấy."}

  def cannot_add_self
    errors.add(:sender_id, 'bạn không thể kết bạn với chính mình.') if sender_id == receiver_id
  end

  def add
    self.arr = [[self.sender_id, self.receiver_id].min, [self.sender_id, self.receiver_id].max]
  end

  serialize :arr, Array
end
