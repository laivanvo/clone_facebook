class MemberRelation < ApplicationRecord
  enum relation_type: %i[requested joined admin], _default: :requested

  belongs_to :user
  belongs_to :group
end
