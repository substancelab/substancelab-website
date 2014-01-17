require 'active_support/core_ext/array/grouping'

module ProjectHelpers
  def case_studies
    data.projects.select { |slug, values|
      values['case_study'] == true
    }.values.sort_by(&:position)
  end

  def featured_projects
    data.projects.select { |slug, values|
      values['featured'] == true
    }.values.sort_by(&:position)
  end

  def project_bubble(project)
    image = asset_url("/images/work/#{project.slug}/square.jpg")
    link_to(I18n.t("work.index.link_to_case_study", :client => project.client, :project => project.name), project_url(project), :class => 'site', :style => "background-image: url(#{image})")
  end

  def portfolio_projects
    projects = case_studies.sort_by { |p| [p.position, p.name.downcase] }
    projects += featured_projects.select { |project| !project.case_study}.sort_by { |p| [p.position, p.name.downcase] }

    # Always return in tripples
    projects = projects.first(projects.size - projects.size % 3)
  end

  def projects_url
    "/work/"
  end

  def project_code_image_path(project)
    image = File.join("work", project.slug, "code.jpg")
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
