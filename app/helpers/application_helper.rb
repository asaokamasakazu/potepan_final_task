module ApplicationHelper
  BASE_TITLE = "BIGBAG Store".freeze
  
  def full_title(page_title)
    if page_title.empty? || page_title.nil?
      BASE_TITLE
    else
      page_title + " - " + BASE_TITLE
    end
  end
end
