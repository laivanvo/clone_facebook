class Relation < ApplicationRecord
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'

  enum _type: %i[request friend], _default: :request
end
