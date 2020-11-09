# frozen_string_literal: true

module AssetHelpers
  def image_exists?(path)
    File.exist?(File.join(config[:source], config[:images_dir], path))
  end

  # Returns an absolute URL to the specified image
  def image_url(image)
    path = image_path(image)
    return if path.start_with?("http")

    protocol = config[:protocol]
    port = config[:port]
    hostname = config[:host]
    hostname = "#{hostname}:#{port}" if port && port.to_i != 80
    "#{protocol}#{hostname}#{path}"
  end
end
