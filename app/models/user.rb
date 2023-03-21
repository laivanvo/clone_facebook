class User < ApplicationRecord
  has_one :profile
  has_many :senders, foreign_key: 'sender_id', class_name: 'Relation'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Relation'
  has_many :posts
  has_many :groups
  has_many :member_relations


  before_create :add_token
  after_create :add_profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] &&
                session['devise.facebook_data']['extra']['raw_info']) && user.email.blank?
        user.email = data['email']
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def joined_groups
    Group.where(id: self.member_relations.joined.pluck(:user_id))
  end

  def friends
    friend_ids = (self.senders.friend.pluck(:receiver_id) + self.receivers.friend.pluck(:sender_id)).uniq
    User.where(id: friend_ids).order(created_at: :desc)
  end

  def home_posts
    Post.where(user_id: (self.friends.pluck(:id).push(self.id))).order(created_at: :desc)
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

  def recommend_users
    User.where.not(id: self.sender_ids.concat(self.receiver_ids))
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

  def add_profile
    self.create_profile name: self.name
  end
end
