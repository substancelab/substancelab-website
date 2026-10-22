# frozen_string_literal: true

module ArticleHelpers
  def blog_articles
    site.collections.posts.resources
      .select { |r| r.data.published != false && r.data.locale.to_s == current_locale }
      .sort_by { |r| r.date }
      .reverse
  rescue
    []
  end

  def current_article
    view.resource
  end

  def newer_article(article)
    index = blog_articles.index(article)
    blog_articles[index - 1] if index&.positive?
  end

  def older_article(article)
    index = blog_articles.index(article)
    blog_articles[index + 1] if index
  end

  def article_data(article)
    article.data
  end

  def article_image(article, transformations = [])
    article_image_from_cloudinary(article, transformations) || article_image_from_disk(article)
  end

  def article_image_from_cloudinary(article, extra_transformations = [])
    image = article_photo_data(article, :cloudinary)
    return nil unless image

    default_transformations = ["t_masthead", "f_auto"]
    all_transformations = (default_transformations + Array(extra_transformations)).sort
    cloudinary_image_url(image, all_transformations)
  end

  def article_photo_data(article, key = nil)
    photo_data = article.data.photo || {}
    photo_data = photo_data.to_h.transform_keys(&:to_sym)
    if key
      photo_data.fetch(key.to_sym, nil)
    else
      photo_data
    end
  end

  def article_image_from_disk(article)
    image = article_photo_data(article, :filename)
    return nil unless image

    if image.to_s.start_with?("http")
      image
    else
      "/images/articles/#{image}"
    end
  end

  # The article content without the READMORE separator, which separates the
  # summary from the rest of the article.
  def article_content(article)
    article.content.to_s.gsub(%r{<p>\s*READMORE\s*</p>\n?|READMORE}, "").html_safe
  end

  def article_summary(article)
    content = article.content.to_s
    before_readmore = content.split("READMORE").first || content
    strip_tags(before_readmore)
  end

  def link_to_article(article)
    href = article.relative_url
    title = article.data.title
    "<a href=\"#{href}\" title=\"#{CGI.escapeHTML(title.to_s)}\">#{title}</a>".html_safe
  end
end
