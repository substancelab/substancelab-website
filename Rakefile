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
