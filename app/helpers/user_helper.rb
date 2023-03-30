module UserHelper
  def user_avatar(user)
    image_tag(user.avatar_url || "avatar-svgrepo-com.svg")
  end

  def user_address(user)
    user.address && ("Sống tại " + user.address)
  end

  def user_birthday(user)
    user.birthday && ("Sinh nhật " + user.birthday.strftime("ngày %m tháng %d"))
  end
end
