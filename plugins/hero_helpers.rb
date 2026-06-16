# frozen_string_literal: true

module HeroHelpers
  def hero_image(image_url)
    return unless image_url

    set_meta_tags(:thumbnail => hero_image_url(image_url))
  end

  def hero_image_for_article(article)
    image = article_photo_data(article, :cloudinary)
    hero_image(image)
  end

  def hero_image_url(image_url)
    if cloudinary_image_path?(image_url)
      transformations = ["t_masthead", "w_1000", "f_auto"]
      image_url = image_url.split(".").first
      cloudinary_image_url(image_url, transformations)
    else
      image_url
    end
  end
end
