class User < ApplicationRecord
  has_many :posts
  has_many :senders, foreign_key: 'sender_id', class_name: 'Relation'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Relation'

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
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
