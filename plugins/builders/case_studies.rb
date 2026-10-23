# frozen_string_literal: true

class Builders::CaseStudies < SiteBuilder
  include I18nHelpers
  include ProjectHelpers

  def build
    generator do
      locale = site.config.locale.to_s
      template_path = site.in_source_dir("work/_case_study.erb")
      template_content = File.read(template_path)

      site.data.projects.each do |slug, attrs|
        project = attrs.to_h.transform_keys(&:to_s)
        case_study_locales = project["case_studies"] || []
        next unless case_study_locales.include?(locale)

        project_slug = project["slug"] || slug.to_s
        page_title = project_page_title(project)
        page_description = localized(project["description"] || {})
        add_resource :pages, "work/#{project_slug}/index.html" do
          layout "layout"
          body_classes ["case_study"]
          section "portfolio"
          title page_title
          description page_description
          _project project
          content template_content
        end
      end
    end
  end
end
