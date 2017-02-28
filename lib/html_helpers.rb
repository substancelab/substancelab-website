# frozen_string_literal: true
module HtmlHelpers
  def strip_tags(html)
    Rails::Html::FullSanitizer.new.sanitize(html)
  end
end
