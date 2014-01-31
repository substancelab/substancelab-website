module ClientHelpers
  def clients
    data.projects.values.collect { |project|
      OpenStruct.new(
        :name => project.client,
        :website => project.client_website
      )
    }.sort_by { |p| p.name.downcase }.uniq
  end
end
