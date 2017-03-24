# frozen_string_literal: true
module ArticleHelpers
  def article_data(article)
    article.metadata.fetch(:page, {})
  end

  def article_image(article)
    image = article_photo_data(article, :filename)
    return nil unless image
    article_image_path = File.join(article_images_path(article), image)
    image_path(article_image_path)
  end

  def article_photo_data(article, key = nil)
    photo_data = article_data(article).fetch(:photo, {})
    if key
      photo_data.fetch(key, nil)
    else
      photo_data
    end
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
