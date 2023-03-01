FactoryBot.define do
  factory :relation do
    sender_id { User.order("RAND()").first.id }
    receiver_id { User.order("RAND()").second.id }
    relation_type { Faker::Number.between(from: Relation.relation_types[:requested], to: Relation.relation_types[:friend]) }
  end
end
