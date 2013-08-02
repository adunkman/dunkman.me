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

desc "Build site, copy to gh-pages branch, push to GitHub"
task :deploy => [ :build ] do
  tasks = [
    'git symbolic-ref HEAD refs/heads/gh-pages',
    'git reset',
    'rm -rf $(ls | grep -v _site)',
    'mv _site/* ./',
    'rm -rf _site',
    'git add --all',
    'git commit -m \'Automated deployment\'',
    'git checkout master',
    'git reset head --hard',
    'git clean -fqd',
    'git push origin gh-pages:gh-pages'
  ]

  exec tasks.join " && "
end
