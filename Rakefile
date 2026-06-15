# frozen_string_literal: true

require "pathname"

desc "Build and publish the website"
task :deploy => ["bridgetown:build", "deploy:publish"]

namespace :deploy do
  desc "Publish contents of the build directory"
  task :publish do
    target_folder = {
      "da" => "public_html",
      "en" => "substancelab.com"
    }.fetch(ENV["LOCALE"])

    sh "scp -r build/* substancelab.dk@linux41.unoeuro.com:#{target_folder}"
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

namespace :bridgetown do
  desc "Builds the website files into the output directory"
  task :build do
    system "bridgetown build"
  end

  task :clean do
    system "rm -rf output"
  end
end

require "vite_ruby"
ViteRuby.install_tasks
