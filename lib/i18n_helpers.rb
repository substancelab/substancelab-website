module I18nHelpers
  def current_locale
    I18n.locale.to_s
  end

  def fallback_locale
    "en"
  end

  # Renders a partial path for current locale. If the partial doesn't exist for
  # the current locale it will be looked for in the fallback_locale. If it does
  # not exist there either, it will be looked for without a specific locale
  def localized_partial(partial_path, locals = {})
    paths = [
      File.join(current_locale, partial_path),
      File.join(fallback_locale, partial_path)
    ]
    partial_with_fallbacks(paths, locals)
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

  def partial_with_fallbacks(paths, locals = {})
    partial_path = paths.shift
    partial(partial_path, locals)
  rescue Middleman::CoreExtensions::Rendering::TemplateNotFound
    raise if paths.empty?
    puts "#{partial_path.inspect} not found. Falling back to #{paths.inspect}"
    partial_with_fallbacks(paths, locals)
  end
end
