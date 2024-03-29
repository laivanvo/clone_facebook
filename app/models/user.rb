class User < ApplicationRecord
  has_one :profile
  has_many :senders, foreign_key: "sender_id", class_name: "Relation"
  has_many :receivers, foreign_key: "receiver_id", class_name: "Relation"
  has_many :posts
  has_many :groups
  has_many :member_relations
  has_many :reactions
  has_many :comments
  has_many :block_comments
  has_many :notifications

  delegate :name, :avatar_url, :address, :birthday, to: :profile

  before_create :add_token

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"] &&
                 session["devise.facebook_data"]["extra"]["raw_info"]) && user.email.blank?
        user.email = data["email"]
      end
    end
  end

  def self.from_omniauth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |new_user|
      new_user.email = auth.info.email
      new_user.password = Devise.friendly_token[0, 20]
    end
    if user.profile.nil?
      user.create_profile name: auth.info.name
    end
    user
  end

  def self.ransackable_attributes(auth_object = nil)
    ["email"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["block_comments", "comments", "groups", "member_relations", "notifications", "posts", "profile", "reactions", "receivers", "senders"]
  end

  def joined_groups
    Group.where(id: self.member_relations.joined.pluck(:user_id))
  end

  def friends
    friend_ids = (self.senders.friend.pluck(:receiver_id) + self.receivers.friend.pluck(:sender_id)).uniq
    User.where(id: friend_ids).order(created_at: :desc)
  end

  def recommend_users
    User.where.not(id: friends.pluck(:id).push(id))
  end

  def home_posts
    Post.where(user_id: id)
        .or(Post.where(user_id: friends.pluck(:id), group_id: nil).not_only_me)
        .or(Post.where(group_id: joined_groups.pluck(:group_id)).passed)
  end

  def recommend_posts
    Post.where(user_id: recommend_users.pluck(:id), group_id: nil)
  end

  def group_posts
    Post.where(group_id: joined_groups.pluck(:group_id)).passed
  end

  def relation(check_user_id)
    Relation.by_sender([self.id, check_user_id]).by_receiver([self.id, check_user_id]).first
  end

  def common_friends(check_user_id)
    friend_ids = self.friends.pluck(:id)
    check_user_friend_ids = User.find(check_user_id).friends.pluck(:id)
    common_friend_ids = friend_ids & check_user_friend_ids
    User.where(id: common_friend_ids)
  end

  def recommend_groups
    Group.where.not(id: self.member_relations.pluck(:group_id))
  end

  def friend_groups
    MemberRelation.where(group_id: recommend_groups.pluck(:id), user_id: self.friends.pluck(:id))
                  .not_requested
  end

  def relation_group(group_id)
    self.member_relations.where(group_id: group_id).first
  end

  def add_token
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end

  def reaction(ta_duty_id, ta_duty_type)
    self.reactions.find_by(ta_duty_id: ta_duty_id, ta_duty_type: ta_duty_type)
  end

  def be_blocked(post_id)
    self.block_comments.where(post_id: post_id).first
  end

  def friend_birthday
    Profile.where(birthday: Date.today, user_id: friends.pluck(:id)).pluck(:name)
  end
end
