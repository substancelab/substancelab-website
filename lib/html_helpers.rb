# frozen_string_literal: true
module HtmlHelpers
  def strip_tags(html)
    puts "strip_tags currently does nothing."
    # Rails::Html::FullSanitizer.new.sanitize(html)
    html
  end
end
