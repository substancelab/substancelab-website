require 'active_support/core_ext/array/grouping'

module ProjectHelpers
  def all_projects
    data.projects.map { |slug, values|
      build_project(values)
    }.sort_by { |project|
      [project.position, project.name.try(:downcase)]
    }
  end

  def build_project(values)
    OpenStruct.new(values)
  end

  # Returns all projects with case studies in the current locale
  def case_studies
    locale = current_locale
    all_projects.select { |project|
      (project.case_studies || []).include?(locale)
    }
  end

  # Returns true if project has a case study in the current locale
  def case_study?(project)
      Array(project.case_studies).include?(current_locale)
  end

  def featured_projects
    all_projects.select { |project|
      project.featured
    }
  end

  def project_bubble(project)
    image = asset_url("/images/work/#{project.slug}/square.jpg")
    link_to(I18n.t("work.index.link_to_case_study", :client => project.client, :project => project.name), project_url(project), :class => 'site', :style => "background-image: url(#{image})")
  end

  def portfolio_projects
    projects = case_studies
    projects += featured_projects.select { |project| !projects.include?(project) }

    # Always return in tripples
    projects = projects.first(projects.size - projects.size % 3)
  end

  def projects_url
    "/work/"
  end

  def project_masthead_image_path(project)
    image = File.join("work", project.slug, "masthead.jpg")
    if image_exists?(image)
      image_path(image)
    else
      return nil
    end
  end

  def show_code_image_in_header(code_image)
    code_image_url = image_path(code_image)
    css_for_masthead_image(code_image_url)
  end

  def project_image(project)
    image = File.join("work", project.slug, "project.jpg")
    if image_exists?(image)
      content_tag(
        :section,
        content_tag(
          :div,
          image_tag(image, :alt => I18n.t("work.show.screenshot_of_project", :project_name => project.name)),
          :class => "container"
        ),
        :class => 'display-project'
      )
    end
  end

  def project_services(project)
    project.services.collect { |service|
      I18n.t(["services", service].join("."))
    }.sort.to_sentence
  end

  def project_url(project)
    slug = project.slug
    raise "Slug for #{project.inspect} cannot be blank" if slug.blank?
    File.join(projects_url, slug)
  end

  def technologies
    data.projects.collect { |slug, values|
      values.technologies
    }.flatten.compact.uniq.sort
  end
end
