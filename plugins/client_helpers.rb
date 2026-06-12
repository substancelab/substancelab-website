# frozen_string_literal: true

module ClientHelpers
  def clients
    projects = site.data.projects.values.map { |project|
      OpenStruct.new(
        :name => project["client"] || project[:client],
        :website => project["client_website"] || project[:client_website]
      )
    }
    projects.sort_by { |p| p.name.to_s.downcase }.uniq { |p| p.name }
  end
end
