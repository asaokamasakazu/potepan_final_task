module ApplicationHelper
  def full_title(page_title)
    base_title = "BIGBAG Store"
    if page_title.empty? || page_title.nil?
      base_title
    else
      page_title + " - " + base_title
    end
  end
end
