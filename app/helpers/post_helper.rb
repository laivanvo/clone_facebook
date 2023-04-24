module PostHelper
  def post_contents(post)
    render partial: "contents/item", collection: post.contents, as: :content
  end
end
