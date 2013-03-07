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

  def project_image(project)
    image = File.join("work", project.slug, "project.jpg")
    if image_exists?(image)
      image_tag(image, :class => 'display-project')
    end
  end

  def project_url(project)
    slug = project.slug
    raise "Slug for #{project.inspect} cannot be blank" if slug.blank?
    File.join(projects_url, slug)
  end

  # Fetches a specific project from data storage
  def project(key)
    data.projects[key]
  end
end
