# frozen_string_literal: true
module ClientHelpers
  def clients
    projects = data.projects.values.collect { |project|
      OpenStruct.new(
        :name => project.client,
        :website => project.client_website
      )
    }
    projects.sort_by { |p| p.name.downcase }.uniq
  end
end
