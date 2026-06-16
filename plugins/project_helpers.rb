# frozen_string_literal: true

module ProjectHelpers
  def all_projects
    projects = site.data.projects.map { |_slug, values|
      build_project(values)
    }
    projects.sort_by { |project|
      [project["position"] || 9999, project["name"].to_s.downcase]
    }
  end

  def build_project(values)
    values.to_h.transform_keys(&:to_s)
  end

  def case_studies
    locale = current_locale
    all_projects.select { |project|
      (project["case_studies"] || []).include?(locale)
    }
  end

  def case_study_hero(project)
    view.slot(:hero) do
      name = project.is_a?(Hash) ? project["name"] : project.name
      desc = localized(project.is_a?(Hash) ? project["description"] : project.description)
      "<h1>#{CGI.escapeHTML(name.to_s)}</h1><div class=\"subtitle\">#{CGI.escapeHTML(desc.to_s)}</div>".html_safe
    end
  end

  def case_study?(project)
    Array(project.is_a?(Hash) ? project["case_studies"] : project.case_studies).include?(current_locale)
  end

  def featured_projects
    all_projects.select { |p| p["featured"] }
  end

  def project_page_title(project)
    max_page_title_length = 60 - "Substance Lab ".length
    name = project.is_a?(Hash) ? project["name"] : project.name
    prepended = "#{name}: "
    services = project_services(project, :max_length => max_page_title_length - prepended.length)
    prepended + services
  end

  def project_tile(project)
    slug = project.is_a?(Hash) ? project["slug"] : project.slug
    name = project.is_a?(Hash) ? project["name"] : project.name
    description = project.is_a?(Hash) ? project["description"] : project.description
    shortened = localized(description).split(".").first

    background_style = "background-image: url(/images/work/#{slug}/tile.jpg)"
    inner = "<div class=\"tile-text\"><h2 class=\"tile-title\">#{CGI.escapeHTML(name.to_s)}</h2><p>#{CGI.escapeHTML(shortened.to_s)}</p></div>"

    url = case_study?(project) ? project_url(project) : nil
    if url
      "<a href=\"#{url}\" class=\"block-link tile\" style=\"#{background_style}\">#{inner}</a>".html_safe
    else
      "<div class=\"tile\" style=\"#{background_style}\">#{inner}</div>".html_safe
    end
  end

  def portfolio_projects
    case_studies
  end

  def project_hero_image_path(project)
    slug = project.is_a?(Hash) ? project["slug"] : project.slug
    image = "work/#{slug}/masthead.jpg"
    return nil unless image_exists?(image)
    "/images/#{image}"
  end

  def project_image(project)
    slug = project.is_a?(Hash) ? project["slug"] : project.slug
    name = project.is_a?(Hash) ? project["name"] : project.name
    image_path = "work/#{slug}/project.jpg"
    return nil unless image_exists?(image_path)

    alt = CGI.escapeHTML(I18n.t("work.show.screenshot_of_project", :project_name => name.to_s))
    img = "<img src=\"/images/#{image_path}\" alt=\"#{alt}\">"

    url = project.is_a?(Hash) ? project["website"] : project.website
    img_with_link = if url
      title = CGI.escapeHTML(I18n.t("work.index.project_website"))
      "<a href=\"#{url}\" title=\"#{title}\">#{img}</a>"
    else
      img
    end

    "<section class=\"display-project\"><div class=\"container\">#{img_with_link}</div></section>".html_safe
  end

  def project_services(project, max_length: nil)
    services = project.is_a?(Hash) ? project["services"] : project.services
    return "" unless services

    translated = services.map { |s|
      I18n.translate(s, :scope => :services, :default => s.to_s)
    }.sort_by(&:length)

    result = []
    translated.each do |svc|
      candidate = result + [svc]
      break if max_length && candidate.to_sentence.length > max_length
      result << svc
    end

    result.sort.to_sentence
  end

  def project_url(project)
    slug = project.is_a?(Hash) ? project["slug"] : project.slug
    raise "Slug cannot be blank" if slug.to_s.empty?
    "/work/#{slug}/"
  end

  def technologies
    site.data.projects.map { |_slug, values|
      techs = values.is_a?(Hash) ? values["technologies"] : values.technologies
      techs
    }.flatten.compact.uniq.sort
  end
end
