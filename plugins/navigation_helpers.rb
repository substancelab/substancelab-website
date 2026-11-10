# frozen_string_literal: true

require "cgi"

module NavigationHelpers
  def nav_bar_link(key, url)
    label = I18n.translate(key, :scope => "navigation")
    "<li class=\"#{key}\"><a href=\"#{url}\">#{label}</a></li>".html_safe
  end

  # A link for the main navigation. Marked as the current page when the page
  # being rendered is url or lives below it, so /work/ stays active on
  # /work/some-case/.
  def main_nav_link(label, url)
    path = view.resource.relative_url.to_s
    current = path == url || path.start_with?(url)
    attrs = current ? ' aria-current="page"' : ""
    "<a href=\"#{CGI.escapeHTML(url)}\"#{attrs}>#{CGI.escapeHTML(label)}</a>".html_safe
  end

  def nav_bar_link_to_blog
    return "" if blog_articles.empty?
    nav_bar_link(:articles, articles_path)
  end

  def nav_bar_link_to_services
    return "" unless I18n.translate("navigation").key?(:services)
    nav_bar_link(:services, services_url)
  end

  # True if the site has a published page at url. Pages in other locales than
  # the one being built are unpublished by Builders::LocaleGuard.
  def page_exists?(url)
    site.resources.any? { |r| r.data.published != false && r.relative_url == url }
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
