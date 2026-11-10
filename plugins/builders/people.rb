# frozen_string_literal: true

class Builders::People < SiteBuilder
  include I18nHelpers
  include ArticleHelpers
  include PeopleHelpers

  def build
    generator do
      template_path = site.in_source_dir("people/_person.erb")
      template_content = File.read(template_path)

      authors.each do |key|
        page_person = person(key)
        page_description = person_title(page_person)
        add_resource :pages, "people/#{key}/index.html" do
          layout "layout"
          title page_person["name"]
          description page_description
          _person_key key
          content template_content
        end
      end
    end
  end
end
