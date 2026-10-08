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

  def article_body(article)
    article_parts(article).last.html_safe
  end

  def article_data(article)
    article.data
  end

  def article_intro(article)
    article_parts(article).first.html_safe
  end

  def article_parts(article)
    content = article.content.to_s
    content.split("READMORE")
  end

  def article_summary(article)
    content = article.content.to_s
    return content.html_safe unless content.include?("READMORE")

    # Drop the opening tag of the paragraph the separator was in
    content.split("READMORE").first.to_s.sub(%r{\s*<p>\s*\z}, "").html_safe
  end

  def link_to_article(article)
    href = article.relative_url
    title = article.data.title
    "<a href=\"#{href}\" title=\"#{CGI.escapeHTML(title.to_s)}\">#{title}</a>".html_safe
  end
end
