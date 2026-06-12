# frozen_string_literal: true

module AssetHelpers
  def image_exists?(path)
    File.exist?(File.join(site.source, "images", path))
  end

  def image_path(source)
    return source.to_s if source.to_s.start_with?("http", "//", "/")
    "/images/#{source}"
  end

  def image_tag(src, options = {})
    src_val = image_path(src)
    attrs = options.map { |k, v| " #{k}=\"#{v}\"" }.join
    "<img src=\"#{src_val}\"#{attrs}>".html_safe
  end

  def image_url(image)
    path = image_path(image)
    return path if path.start_with?("http")
    "#{site.config.url}#{path}"
  end

  def asset_url(path)
    return path if path.start_with?("http")
    "#{site.config.url}#{path}"
  end
end
