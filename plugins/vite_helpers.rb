# frozen_string_literal: true

require "vite_ruby"

module ViteHelpers
  def vite_client_tag
    src = ViteRuby.instance.manifest.vite_client_src
    return "" unless src

    %(<script type="module" src="#{src}"></script>).html_safe
  end

  def vite_javascript_tag(name, crossorigin: "anonymous", **_options)
    path = ViteRuby.instance.manifest.path_for(name, type: :javascript)
    %(<script src="#{path}" type="module" crossorigin="#{crossorigin}"></script>).html_safe
  end

  def vite_stylesheet_tag(name, **options)
    path = ViteRuby.instance.manifest.path_for(name, type: :stylesheet)
    media = options[:media] ? %( media="#{options[:media]}") : ""
    %(<link rel="stylesheet" href="#{path}"#{media} />).html_safe
  end

  def vite_asset_path(name, **options)
    ViteRuby.instance.manifest.path_for(name, **options)
  end

  Bridgetown::RubyTemplateView::Helpers.include(self)
end
