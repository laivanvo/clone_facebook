module UserHelper
  def user_avatar(user)
    image_tag('avatar_profile.jpg')
  end

  def user_name(user)
    user.name || 'người dùng facebook'
  end
end
