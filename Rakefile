namespace :build do
  desc "Build SASS to CSS"
  task :css do
    puts `sass --update --compass --style compressed stylesheets`
  end

  desc "Build site using Jekyll"
  task :site do
    puts `jekyll build`
  end
end

desc  "Build site"
task :build => [ 'build:css', 'build:site' ]
