class BlockComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id, message: "đã chặn user này trước đó" }
end
