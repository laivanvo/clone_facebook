class User < ApplicationRecord
  has_many :posts
  has_many :senders, foreign_key: 'sender_id', class_name: 'Relation'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Relation'
  has_many :groups
  has_many :member_relations
  has_and_belongs_to_many :relation_groups, class_name: 'Group', join_table: 'member_relations'
  has_and_belongs_to_many :joined_groups,
    -> { where "member_relations.relation_type = #{MemberRelation.relation_types[:joined]}" },
    class_name: 'Group',
    join_table: 'member_relations'
  enum role: %i[user admin]

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

  def friends
    User::where(id: senders.friend.pluck(:receiver_id) + receivers.friend.pluck(:sender_id))
  end

  def home_posts
    Post::where(user_id: self.id).or(Post::where(user_id: self.friends.pluck(:id)))
  end

  def relations
    Relation::where('sender_id=? or receiver_id=?', self.id, self.id)
  end

  def relation(check_user_id)
    Relation::where('sender_id=? or receiver_id=?', self.id, self.id).where('sender_id=? or receiver_id=?', check_user_id, check_user_id).first
  end

  def common_friends(check_user_id)
    User.where(id: self.friends.pluck(:id)).where(id: User.find(check_user_id).friends.pluck(:id))
  end

  def recommend_groups
    Group::where('user_id!=?', self.id).where.not(id: self.relation_groups)
  end

  def friend_groups
    Group.where(user_id: self.friends.pluck(:id))
  end

  def relation_group(group_id)
    self.member_relations.where(group_id: group_id).first
  end

  def is_permissioned relation_id
    self.member_relations.where(group_id: MemberRelation.find(relation_id).group_id).first.admin?
  end
end
