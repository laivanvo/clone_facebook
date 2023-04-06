module ApplicationHelper
  def created_at(table)
    time_ago_in_words(table.created_at)
  end
end
