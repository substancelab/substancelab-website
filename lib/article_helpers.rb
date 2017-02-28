# frozen_string_literal: true
module ArticleHelpers
  def article_data(article)
    article.metadata.fetch(:page, {})
  end

  def article_image(article)
    image = article_photo_data(article, "filename")
    if image
      article_image_path = File.join(article_images_path(article), image)
      image_path(article_image_path)
    end
  end

  def article_photo_data(article, key = nil)
    photo_data = article_data(article).fetch("photo", {})
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

  # Returns the full path to article
  def article_path(article)
    permalink = blog.options.permalink
    article_date = article.date

    # This snippet is copied from blog_data.rb in blog-middleman
    permalink.
      sub(":year", article_date.year.to_s).
      sub(":month", article_date.month.to_s.rjust(2, "0")).
      sub(":day", article_date.day.to_s.rjust(2, "0")).
      sub(":title", article.slug)
  end

  def articles_path
    blog.options.prefix
  end

  def link_to_article(article)
    href = article_path(article)
    title = article.title
    if block_given?
      link_to(href, :title => title, &block)
    else
      link_to(title, href, :title => title)
    end
  end
end
