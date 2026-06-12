# frozen_string_literal: true

require "vite_ruby"

module ViteHelpers
  def vite_client_tag
    ""
  end

  def vite_javascript_tag(name, crossorigin: "anonymous", **_options)
    path = vite_manifest_path("entrypoints/#{name}")
    %(<script src="#{path}" type="module" crossorigin="#{crossorigin}"></script>).html_safe
  end

  def vite_stylesheet_tag(name, **options)
    path = vite_manifest_path("entrypoints/#{name}")
    media = options[:media] ? %( media="#{options[:media]}") : ""
    %(<link rel="stylesheet" href="#{path}"#{media} />).html_safe
  end

  def vite_asset_path(name, **_options)
    vite_manifest_path(name)
  end

  private

  def vite_manifest_path(name)
    config = ViteRuby.instance.config
    manifest = config.manifest_paths
      .map { |p| JSON.parse(p.read) }
      .inject({}, &:merge)
    entry = manifest[name] || raise("Vite manifest entry not found: #{name}")
    "/#{config.public_output_dir}/#{entry["file"]}"
  end

  Bridgetown::RubyTemplateView::Helpers.include(self)
end
