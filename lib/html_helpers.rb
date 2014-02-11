module HtmlHelpers
  def strip_tags(html)
    HTML::FullSanitizer.new.sanitize(html)
  end
end
