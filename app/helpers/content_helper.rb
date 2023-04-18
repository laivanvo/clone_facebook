module ContentHelper
  def content_file(content)
    content.file_url && image_tag(content.file_url)
  end
end
