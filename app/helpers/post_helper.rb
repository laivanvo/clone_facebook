module PostHelper
  def post_content(post)
    image_tag(post.content_url || "cover_image.jpg")
  end

  def post_created_at(post)
    time_ago_in_words(post.created_at)
  end
end
