# frozen_string_literal: true

module ArticleHelpers
  def article_data(article)
    article.metadata.fetch(:page, {})
  end

  def article_image(article, transformations = [])
    article_image_from_cloudinary(article, transformations) || article_image_from_disk(article)
  end

  def article_image_from_cloudinary(article, extra_transformations = [])
    image = article_photo_data(article, :cloudinary)
    return nil unless image

    base_url = "https://res.cloudinary.com/substancelab/image/upload"
    transformations = ["t_masthead", "f_auto"]

    [base_url, transformations, extra_transformations, image].flatten.join("/")
  end

  def article_photo_data(article, key = nil)
    photo_data = article_data(article).fetch(:photo, {})
    if key
      photo_data.fetch(key.intern, nil)
    else
      photo_data
    end
  end

  def article_image_from_disk(article)
    image = article_photo_data(article, :filename)
    return nil unless image

    article_image_path = if image.start_with?("http")
      image
    else
      File.join(article_images_path(article), image)
    end

    image_path(article_image_path)
  end

  # Returns the path where images for the current article are stored
  def article_images_path(_article)
    File.join("articles")
  end

  def articles_path
    blog.options.prefix
  end

  def link_to_article(article)
    href = article.url
    title = article.title
    if block_given?
      link_to(href, :title => title, &block)
    else
      link_to(title, href, :title => title)
    end
  end
end
