class Group < ApplicationRecord
  enum mode: %i[fu far], _default: :public

  belongs_to :user
  has_many :member_relations
  has_many :posts

  after_create :add_admin

  mount_uploader :avatar, GroupFileUploader

  def add_admin
    self.member_relations.create user_id: self.user_id, relation_type: :admin
  end

  def admins
    self.member_relations.admin
  end

  def members
    self.member_relations.joined
  end

  def joiners
    self.member_relations.not_requested
  end
end
