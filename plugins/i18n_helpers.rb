# frozen_string_literal: true

module I18nHelpers
  def current_locale
    site.config.locale.to_s
  end

  def fallback_locale
    "en"
  end

  def has_services?
    I18n.translate("navigation").key?(:services)
  end

  def localized_partial(partial_path, locals = {})
    clean_path = partial_path.sub(/\.(html\.)?(erb|slim|liquid)$/, "")
    paths = [
      File.join(current_locale, clean_path),
      File.join(fallback_locale, clean_path)
    ]
    partial_with_fallbacks(paths, locals)
  end

  def localized_partial_if_present(partial_path, locals = {})
    localized_partial(partial_path, locals)
  rescue StandardError
    ""
  end

  def localized(content)
    if content.respond_to?(:fetch)
      content.fetch(current_locale, content.fetch(fallback_locale, ""))
    else
      content.to_s
    end
  end

  def partial_with_fallbacks(paths, locals = {})
    path = paths.shift
    if partial_file_exists?(path)
      view.partial(path, :locals => locals)
    elsif paths.any?
      partial_with_fallbacks(paths, locals)
    else
      raise "Partial not found in any of the tried paths"
    end
  end

  private

  def partial_file_exists?(path)
    dir = File.dirname(path)
    base = File.basename(path)
    full_path = File.join(site.source, dir, "_#{base}.erb")
    File.exist?(full_path)
  end
end
