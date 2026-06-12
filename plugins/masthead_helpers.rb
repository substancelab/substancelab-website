# frozen_string_literal: true

module MastheadHelpers
  def masthead_image(image_url)
    return unless image_url

    image_url = masthead_image_url(image_url)
    set_meta_tags(:thumbnail => image_url)

    view.slot(:page_specific_style) do
      css = css_for_masthead_image(image_url)
      "<style>#{css}</style>".html_safe
    end
  end

  def masthead_image_for_article(article)
    image = article_photo_data(article, :cloudinary)
    masthead_image(image)
  end

  def masthead_image_url(image_url)
    if cloudinary_image_path?(image_url)
      transformations = ["t_masthead", "w_1000", "f_auto"]
      image_url = image_url.split(".").first
      cloudinary_image_url(image_url, transformations)
    else
      image_url
    end
  end

  def css_for_masthead_image(image_url)
    <<~CSS
      .masthead {
        background-image: url('#{image_url}');
        background-size: cover;
        background-position: center;
      }
    CSS
  end
end
