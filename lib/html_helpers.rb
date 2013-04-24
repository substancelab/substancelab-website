require 'active_support/dependencies/autoload'
require 'action_controller/vendor/html-scanner'

module HtmlHelpers
  def strip_tags(html)
    HTML::FullSanitizer.new.sanitize(html)
  end
end
