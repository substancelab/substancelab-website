# frozen_string_literal: true

module CloudinaryHelpers
  def cloudinary_image_url(image_path, transformation = nil)
    base_url = "https://res.cloudinary.com/substancelab/image/upload"
    [base_url, transformation, image_path].compact.join("/")
  end

  # Returns true if path looks like a Cloudinary image identifier
  def cloudinary_image_path?(path)
    return false unless path.respond_to?(:match?)

    path.match?(/\Av\d+\/substancelab-website\//)
  end
end
