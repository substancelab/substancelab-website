
module ProjectHelpers
  def case_studies
    data.projects.select { |slug, values|
      values['case_study'] == true
    }
  end

  def featured_projects
    data.projects.select { |slug, values|
      values['featured'] == true
    }
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
