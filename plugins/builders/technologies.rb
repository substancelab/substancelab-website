# frozen_string_literal: true

# Generates a page for each technology at /work/with/<technology>/, listing the
# projects built with it.
class Builders::Technologies < SiteBuilder
  include I18nHelpers
  include ProjectHelpers

  def build
    generator do
      template_content = File.read(site.in_source_dir("work/_technology.erb"))

      technologies.each do |technology|
        page_title = I18n.t("work.technology.title", technology: technology)
        page_description = I18n.t("work.technology.meta_description", technology: technology)
        add_resource :pages, "#{technology_url(technology).delete_prefix("/")}index.html" do
          layout "layout"
          section "portfolio"
          title page_title
          description page_description
          _technology technology
          content template_content
        end
      end
    end
  end
end
