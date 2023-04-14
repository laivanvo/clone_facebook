class Group < ApplicationRecord
  enum mode: %i[fu far], _default: :public

  belongs_to :user
  has_many :member_relations
  has_many :posts

  after_create :add_admin

  mount_uploader :avatar, GroupFileUploader

  def self.ransackable_attributes(auth_object = nil)
    ["avatar", "created_at", "id", "name", "public", "updated_at", "user_id"]
  end

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
