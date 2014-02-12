task :deploy => "middleman:deploy"

namespace :images do
  task :optimize => ["optimize:all"]

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

  desc "Deploys the site to whatever host is configured in middleman"
  task :deploy => :build do
    system 'middleman deploy'
  end
end
