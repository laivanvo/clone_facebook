module GroupHelper
  def group_avatar(group)
    image_tag(group.avatar_url || 'cover_image.jpg')
  end

  def group_user_name(group)
    group.user.profile.name ? group.user.profile.name : group.user.email
  end

  def group_mode(group)
    group.public ? 'Công khai' : 'Riêng tư'
  end

  def group_mode_info(group)
    group.public ?
    'Ai cũng có thể nhìn thấy mọi người trong nhóm và những gì họ đăng.' :
    'Chỉ thành viên mới nhìn thấy mọi người trong nhóm và những gì họ đăng.'
  end

  def group_created_at(group)
    'Đã tạo nhóm vào ' + group.created_at.strftime('ngày %m tháng %d năm %Y')
  end
end
