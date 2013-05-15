module I18nHelpers

  def current_locale
    I18n.locale.to_s
  end

  def fallback_locale
    "en"
  end

  # If partial exists for the current locale, that partial is rendered
  def localized_partial(partial_path)
    full_path = File.join(I18n.locale.to_s, partial_path)
    partial(full_path)
  rescue Middleman::CoreExtensions::Rendering::TemplateNotFound
    puts "#{partial_path.inspect} not found for locale #{I18n.locale.to_s} at #{full_path.inspect}. Falling back to #{fallback_locale.inspect}"
    # The partial doesn't exist for current locale, fall back to fallback locale
    partial(File.join(fallback_locale, partial_path))
  end

  # Returns content in current locale. If content has no translation for
  # current locale, the english description is returned
  def localized(content)
    if content.respond_to?(:fetch)
      content.fetch(I18n.locale.to_s, content.fetch(fallback_locale))
    else
      content
    end
  end

end
