task :deploy => "middleman:deploy"

namespace :images do
  task :optimize => ["optimize:all"]

  namespace :masthead do
    desc "Creates masthead images from originals"
    task :convert do
      system 'find originals -name "*.jpg" -print -exec ./scripts/mastheadify {} \;'
    end

    task :create => [:convert, "optimize:jpg"]
  end

  namespace :optimize do
    task :all => [:jpg, :png]

    task :jpg do
      system 'find source/images -name *.jpg -exec jpegoptim {} \;'
    end

    task :png do
      system 'find source/images -name *.png -exec optipng {} \;'
    end
  end
end

namespace :middleman do
  desc "Builds the website files into the build directory"
  task :build do
    system 'middleman build --clean'
  end

  task :clean do
    system 'rm -rf build'
  end

  desc "Deploys the site to whatever host is configured in middleman"
  task :deploy => [:clean, :build] do
    host = "linux41.unoeuro.com"
    user = "substancelab.dk"
    password = "jQBhDPEKAkzxa8jpjarJHTGZna4sdKLUMyGPNEiiKQtLTgcvZT"
    ftp_url = "ftp://#{user}:#{password}@#{host}"

    local_dir = File.join(Dir.pwd, "build")

    LOCALE = (ENV["LOCALE"] || "en").to_s
    remote_dir = {
      'da' => "/public_html/",
      'en' => "/substancelab.com/"
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
