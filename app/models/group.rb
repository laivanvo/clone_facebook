class Group < ApplicationRecord
  belongs_to :user

  has_many :member_relations

  has_and_belongs_to_many :members,
    -> { where "member_relations.relation_type = #{MemberRelation.relation_types[:joined]}" },
    class_name: 'User',
    join_table: 'member_relations'

  has_and_belongs_to_many :admins,
    -> { where "member_relations.relation_type = #{MemberRelation.relation_types[:joined]}" },
    class_name: 'User',
    join_table: 'member_relations'

  has_many :posts


  after_create :add_admin

  mount_uploader :avatar, GroupFileUploader

  def add_admin
    self.member_relations.create :user_id => self.user_id, :relation_type => 'admin'
  end
end
