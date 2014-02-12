task :deploy => "middleman:deploy"

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
