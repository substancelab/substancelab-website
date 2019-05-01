# frozen_string_literal: true

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
  #
  # If the partial cannot be found in the current locale, the fallback locale,
  # nor without a specific locale, Middleman::TemplateRenderer::TemplateNotFound
  # is raised.
  def localized_partial(partial_path, locals = {})
    paths = [
      File.join(current_locale, partial_path),
      File.join(fallback_locale, partial_path)
    ]
    partial_with_fallbacks(paths, locals)
  end

  # Renders a partial path for current locale. If the partial doesn't exist for
  # the current locale it will be looked for in the fallback_locale. If it does
  # not exist there either, it will be looked for without a specific locale.
  #
  # If the partial cannot be found in the current locale, the fallback locale,
  # nor without a specific locale, a blank string is returned.
  def localized_partial_if_present(partial_path, locals = {})
    localized_partial(partial_path, locals)
  rescue Middleman::TemplateRenderer::TemplateNotFound
    ""
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
  rescue Middleman::TemplateRenderer::TemplateNotFound
    raise if paths.empty?
    puts "#{partial_path.inspect} not found. Falling back to #{paths.inspect}"
    partial_with_fallbacks(paths, locals)
  end
end
