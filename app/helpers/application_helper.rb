module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://', 'https://') ? url : "http://#{url}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def fa_icon(class_icon, opts={})
    fa_class = "#{class_icon}"
    if opts[:class]
      fa_class = "#{class_icon + ' ' + opts[:class]}"
    end
    link = "<i class=#{fa_class}></i>"
    link.html_safe
  end
end
