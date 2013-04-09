module ArticleHelpers
  # Returns the full path to article
  def article_path(article)
    permalink = blog.options.permalink
    article_date = article.date

    # This snippet is copied from blog_data.rb in blog-middleman
    permalink.
      sub(':year', article_date.year.to_s).
      sub(':month', article_date.month.to_s.rjust(2,'0')).
      sub(':day', article_date.day.to_s.rjust(2,'0')).
      sub(':title', article.slug)
  end

  def link_to_article(article)
    link_to(article.title, article_path(article), :title => article.summary)
  end
end
