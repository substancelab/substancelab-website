# frozen_string_literal: true
require "active_support/core_ext/array/grouping"

module ProjectHelpers
  def all_projects
    projects = data.projects.map { |_slug, values|
      build_project(values)
    }
    projects.sort_by { |project|
      [project.position, project.name.try(:downcase).to_s]
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

  # Adds project title and description to the masthead
  def case_study_masthead(project)
    content_for(:masthead) do
      content_tag(:h1, project.name) +
        content_tag(:div, localized(project.description), :class => "subtitle")
    end
  end

  # Returns true if project has a case study in the current locale
  def case_study?(project)
    Array(project.case_studies).include?(current_locale)
  end

  def featured_projects
    all_projects.select(&:featured)
  end

  def project_tile(project)
    shortened_description = localized(project.description).split(".").first
    description = capture do
      content_tag(:h2, project.name, :class => "tile-title") +
        content_tag(:p, localized(shortened_description))
    end

    background_image = ["/images", "work", project.slug, "tile.jpg"].join("/")
    background_style = "background-image: url(#{background_image})"

    tile_contents = capture do
      content_tag(:div, description, :class => "tile-text")
    end

    url = case_study?(project) ? project_url(project) : nil
    if url
      link_to(tile_contents, url, :class => "block-link tile", :style => background_style)
    else
      content_tag(:div, tile_contents, :class => "tile", :style => background_style)
    end
  end

  def portfolio_projects
    projects = case_studies
    projects += featured_projects.select do |project|
      !projects.include?(project)
    end

    # Always return in tripples
    projects = projects.first(projects.size - projects.size % 3)
  end

  def project_masthead_image_path(project)
    image = File.join("work", project.slug, "masthead.jpg")
    return nil unless image_exists?(image)
    image_path(image)
  end

  def show_code_image_in_header(code_image)
    code_image_url = image_path(code_image)
    css_for_masthead_image(code_image_url)
  end

  def project_image(project)
    image_path = File.join("work", project.slug, "project.jpg")
    return nil unless image_exists?(image_path)
    image = image_tag(
      image_path,
      :alt => I18n.t(
        "work.show.screenshot_of_project",
        :project_name => project.name
      )
    )

    url = project.website
    image_with_link = if url
      link_to(
        image,
        url,
        :title => I18n.t("work.index.project_website")
      )
    else
      image
    end

    content_tag(
      :section,
      content_tag(
        :div,
        image_with_link,
        :class => "container"
      ),
      :class => "display-project"
    )
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
    data.projects.collect { |_slug, values|
      values.technologies
    }.flatten.compact.uniq.sort
  end
end
