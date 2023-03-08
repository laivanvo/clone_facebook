module ProfileHelper
  def profile_name(profile)
    profile.name || 'người dùng facebook'
  end

  def profile_avatar(profile)
    profile.avatar_url && image_tag(avatar_url)
  end

  def profile_address(profile)
    profile.address && ('Sống tại ' + profile.address)
  end

  def profile_birthday(profile)
    profile.birthday && ('Sinh nhật ' + profile.birthday.strftime('ngày %m tháng %d'))
  end

end
