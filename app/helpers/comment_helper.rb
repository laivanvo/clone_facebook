module CommentHelper
  def comment_file(comment)
    comment.file_url && image_tag(comment.file_url)
  end

  def comment_created_at(comment)
    comment.created_at && time_ago_in_words(comment.created_at) + ' ago'
  end
end
