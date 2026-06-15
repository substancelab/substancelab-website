# frozen_string_literal: true

require "pathname"
require "bridgetown"

Bridgetown.load_tasks

# Run rake without specifying any command to execute a deploy build by default.
task default: :deploy

desc "Build the Bridgetown site for deployment"
task :deploy => [:clean, "frontend:build"] do
  Bridgetown::Commands::Build.start
end

desc "Runs the clean command"
task :clean do
  Bridgetown::Commands::Clean.start
end

namespace :frontend do
  desc "Build the frontend with esbuild for deployment"
  task :build do
    sh "yarn esbuild"
  end

  desc "Watch the frontend with esbuild during development"
  task :dev do
    sh "yarn esbuild-dev"
  rescue Interrupt
  end
end

namespace :images do
  task :optimize => ["optimize:all"]

  namespace :masthead do
    MASTHEAD_ORIGINALS = Pathname.new("originals")
    MASTHEAD_DESTINATION = Pathname.new("src/images")

    masthead_article_images = Rake::FileList.new(
      MASTHEAD_ORIGINALS.join("articles/*.jpg").to_s
    )
    masthead_article_originals = masthead_article_images.collect { |file|
      file.sub(MASTHEAD_ORIGINALS.to_s, MASTHEAD_DESTINATION.to_s)
    }

    article_mastheads = \
      Regexp.new("^#{MASTHEAD_DESTINATION.join('articles')}/.+\\.jpg")
    rule article_mastheads do |task|
      source_path = task.name.sub(
        MASTHEAD_DESTINATION.to_s,
        MASTHEAD_ORIGINALS.to_s
      )
      puts source_path.to_s
      system "script/mastheadify", source_path.to_s
      system "jpegoptim --strip-all", task.name
    end

    desc "Creates masthead images from originals"
    task :create => masthead_article_originals
  end

  desc "Creates favicons and touch icons from images/favicon_template.png"
  task :favicons do
    images = Pathname.new("src/images")
    template = images.join("favicon_template.png")
    icons = {
      "apple-touch-icon-152x152-precomposed.png" => "152x152",
      "apple-touch-icon-144x144-precomposed.png" => "144x144",
      "apple-touch-icon-114x114-precomposed.png" => "114x114",
      "apple-touch-icon-72x72-precomposed.png" => "72x72",
      "apple-touch-icon-precomposed.png" => "57x57",
      "apple-touch-icon.png" => "57x57",
      "favicon.png" => "16x16",
      "mstile-144x144.png" => "144x144"
    }
    icons.each do |icon, size|
      sh "magick", template.to_s, "-resize", size, images.join(icon).to_s
    end

    sh "magick", template.to_s, "-define", "icon:auto-resize=64,32,24,16", images.join("favicon.ico").to_s
  end

  namespace :optimize do
    task :all => [:jpg, :png]

    task :jpg do
      system 'find src/images -name *.jpg -exec jpegoptim --strip-all {} \;'
    end

    task :png do
      system 'find src/images -name *.png -exec optipng {} \;'
    end
  end
end
