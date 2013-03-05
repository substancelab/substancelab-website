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

  def project_url(project)
    slug = project["slug"]
    raise "Slug for #{project.inspect} cannot be blank" if slug.blank?
    File.join(projects_url, project["slug"])
  end

end
