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

  def project_url(project)
    File.join("/work/#{project["slug"]}")
  end

end
