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

  # READMORE ends up inside the paragraph markup – as a paragraph of its own,
  # or at the start or end of another paragraph – so move the <p> tags around
  # it to leave both parts balanced.
  def article_parts(article)
    intro, body = article.content.to_s.split(/\s*READMORE\s*/, 2)
    return [intro] unless body

    if intro.end_with?("<p>") && body.start_with?("</p>")
      intro = intro.delete_suffix("<p>")
      body = body.delete_prefix("</p>")
    elsif body.start_with?("</p>")
      intro += "</p>"
      body = body.delete_prefix("</p>")
    elsif intro.end_with?("<p>")
      intro = intro.delete_suffix("<p>")
      body = "<p>#{body}"
    end

    [intro, body]
  end

  def article_summary(article)
    content = article.content.to_s
    return content.html_safe unless content.include?("READMORE")

    # Drop the opening tag of the paragraph the separator was in
    content.split("READMORE").first.to_s.sub(%r{\s*<p>\s*\z}, "").html_safe
  end

  def link_to_article(article, prefix: nil, suffix: nil)
    href = article.relative_url
    title = article.data.title
    label = [prefix, title, suffix].compact.join(" ")
    "<a href=\"#{href}\" title=\"#{CGI.escapeHTML(title.to_s)}\">#{label}</a>".html_safe
  end
end
