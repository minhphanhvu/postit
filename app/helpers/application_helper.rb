module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://', 'https://') ? url : "http://#{url}"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
