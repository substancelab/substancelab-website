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
