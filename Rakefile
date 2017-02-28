# frozen_string_literal: true
task :deploy => "middleman:deploy"

namespace :images do
  task :optimize => ["optimize:all"]

  namespace :masthead do
    MASTHEAD_ORIGINALS = Pathname.new("originals")
    MASTHEAD_DESTINATION = Pathname.new("source/images")

    masthead_article_images = Rake::FileList.new(MASTHEAD_ORIGINALS.join("articles/*.jpg").to_s)
    masthead_article_originals = masthead_article_images.collect { |file|
      file.sub(MASTHEAD_ORIGINALS.to_s, MASTHEAD_DESTINATION.to_s)
    }

    rule Regexp.new("^#{MASTHEAD_DESTINATION.join('articles')}/.+\\.jpg") do |task|
      source_path = task.name.sub(MASTHEAD_DESTINATION.to_s, MASTHEAD_ORIGINALS.to_s)
      puts source_path.to_s
      system "scripts/mastheadify", source_path.to_s
      system "jpegoptim --strip-all", task.name
    end

    desc "Creates masthead images from originals"
    task :create => masthead_article_originals
  end

  namespace :optimize do
    task :all => [:jpg, :png]

    task :jpg do
      system 'find source/images -name *.jpg -exec jpegoptim --strip-all {} \;'
    end

    task :png do
      system 'find source/images -name *.png -exec optipng {} \;'
    end
  end
end

namespace :middleman do
  desc "Builds the website files into the build directory"
  task :build do
    system "middleman build --clean"
  end

  task :clean do
    system "rm -rf build"
  end

  desc "Deploys the site to whatever host is configured in middleman"
  task :deploy => [:clean, :build] do
    host = "linux41.unoeuro.com"
    user = "substancelab.dk"
    password = "jQBhDPEKAkzxa8jpjarJHTGZna4sdKLUMyGPNEiiKQtLTgcvZT"
    ftp_url = "ftp://#{user}:#{password}@#{host}"

    local_dir = Pathname.new(File.join(Dir.pwd, "build"))
    raise "Build directory not found at #{local_dir}" unless local_dir.exist?

    LOCALE = (ENV["LOCALE"] || "en").to_s
    remote_dir = {
      "da" => "/public_html/",
      "en" => "/substancelab.com/"
    }[LOCALE]

    ftp_script = <<-EOS
      set ftp:list-options -a;
      open #{ftp_url};
      lcd #{local_dir};
      cd #{remote_dir};
      mirror --reverse --verbose"
    EOS
    system "lftp", "-c #{ftp_script}"
  end
end
