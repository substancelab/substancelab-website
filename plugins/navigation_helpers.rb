# frozen_string_literal: true

module NavigationHelpers
  def nav_bar_link(key, url)
    label = I18n.translate(key, :scope => "navigation")
    "<li class=\"#{key}\"><a href=\"#{url}\">#{label}</a></li>".html_safe
  end

  def nav_bar_link_to_blog
    return "" if blog_articles.empty?
    nav_bar_link(:articles, articles_path)
  end

  def nav_bar_link_to_services
    return "" unless I18n.translate("navigation").key?(:services)
    nav_bar_link(:services, services_url)
  end

  def articles_path
    "/articles/"
  end

  def projects_url
    "/work/"
  end

  def services_url
    "/services/"
  end
end
