module PostHelper
  def post_content(post)
    image_tag(post.content_url || "cover_image.jpg")
  end
end
