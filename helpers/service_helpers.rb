# frozen_string_literal: true

module ServiceHelpers
  def link_to_services
    if I18n.translate("navigation").key?(:services)
      link_to(I18n.translate("navigation.services"), services_url)
    else
      ""
    end
  end

  def services_url
    "/services"
  end
end
