# frozen_string_literal: true

module NavigationHelpers
  def nav_bar_link(key, url)
    content_tag("li", :class => key) do
      link_to(
        I18n.translate(key, :scope => "navigation"),
        url
      )
    end
  end

  def nav_bar_link_to_blog
    return "" if blog.articles.empty?
    nav_bar_link(:articles, articles_path)
  end

  def nav_bar_link_to_services
    return "" unless I18n.translate("navigation").key?(:services)
    nav_bar_link(:services, services_url)
  end

  def projects_url
    "/work"
  end

  def services_url
    "/services"
  end
end
