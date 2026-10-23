class Builders::LocaleGuard < SiteBuilder
  def build
    hook :resources, :post_read do |resource|
      page_locale = resource.data.locale&.to_s
      next unless page_locale
      next if page_locale == site.config.locale.to_s

      resource.data.published = false
    end
  end
end
