# frozen_string_literal: true

require "htmlbeautifier"

# Re-indents the rendered HTML of every page so the output source is tidy and
# consistently nested, regardless of how partials and layouts were indented.
class Builders::HTMLFormatter < SiteBuilder
  def build
    hook :resources, :post_render do |resource|
      next unless resource.destination&.output_ext == ".html"

      resource.output = beautify(resource.output)
    end

    hook :generated_pages, :post_render do |page|
      next unless page.output_ext == ".html"

      page.output = beautify(page.output)
    end
  end

  private

  def beautify(html)
    HtmlBeautifier.beautify(html, indent: "  ", keep_blank_lines: 1) + "\n"
  end
end
