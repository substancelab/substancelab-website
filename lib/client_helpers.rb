module ClientHelpers
  def clients
    data.projects.values.collect { |project|
      OpenStruct.new(
        :name => project.client,
        :website => project.client_website
      )
    }.sort_by(&:name)
  end
end
