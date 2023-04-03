module UserHelper
  def user_avatar(user)
    image_tag(user.avatar_url || "avatar-svgrepo-com.svg")
  end

  def user_address(user)
    user.address && ("Sống tại " + user.address)
  end

  def user_friend_birthday(user)
    list_user = user.friend_birthday.join(", ")
    list_user.empty? ? "" : t("share.birthday_today", list_user: list_user)
  end
end
