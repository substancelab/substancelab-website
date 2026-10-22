# frozen_string_literal: true

require "vite_ruby"

# Resolves assets through ViteRuby's manifest, which points to the Vite
# development server when it is running and to the built assets otherwise.
module ViteHelpers
  def vite_client_tag
    src = vite_manifest.vite_client_src
    return "" unless src

    %(<script src="#{src}" type="module"></script>).html_safe
  end

  def vite_javascript_tag(name, crossorigin: "anonymous", **_options)
    path = vite_manifest.path_for(name, :type => :javascript)
    %(<script src="#{path}" type="module" crossorigin="#{crossorigin}"></script>).html_safe
  end

  def vite_stylesheet_tag(name, **options)
    path = vite_manifest.path_for(name, :type => :stylesheet)
    media = options[:media] ? %( media="#{options[:media]}") : ""
    %(<link rel="stylesheet" href="#{path}"#{media} />).html_safe
  end

  def vite_asset_path(name, **options)
    vite_manifest.path_for(name, **options)
  end

  private

  def vite_manifest
    ViteRuby.instance.manifest
  end

  Bridgetown::RubyTemplateView::Helpers.include(self)
end
