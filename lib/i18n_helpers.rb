module I18nHelpers

  def fallback_locale
    "en"
  end

  # If partial exists for the current locale, that partial is rendered
  def localized_partial(partial_path)
    partial(File.join(I18n.locale.to_s, partial_path))
  rescue Middleman::CoreExtensions::Rendering::TemplateNotFound
    # The partial doesn't exist for current locale, fall back to fallback locale
    partial(File.join(fallback_locale, partial_path))
  end

end
