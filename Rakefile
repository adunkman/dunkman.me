task :default => :build

desc "Clean specific unneeded files from _site/ output"
task :clean do
  files = [
    "_site/Rakefile",
    "_site/Gemfile",
    "_site/Gemfile.lock"
  ]

  files.each do |file|
    if File.exists? file
      File.delete file
    end
  end
end

desc "Obliterate the _site/ output directory"
task :obliterate do
  FileUtils.rm_rf("_site/")
end

namespace :build do
  desc "Build site using Jekyll"
  task :site do
    puts `jekyll build`
    puts
  end
end

desc "Build site"
task :build => [ "obliterate", "build:site", "clean" ]

namespace :watch do
  desc "Build site using Jekyll, start development server, and watch for changes"
  task :site do
    exec "jekyll server --watch"
  end
end

desc "Build it all, watch for changes, and serve it up at http://localhost:4000/"
task :watch => [ "watch:site" ]

desc "Deploy site to Amazon S3"
task :deploy => :build do
  require "s3"
  require "mime/types"

  id = ENV["WWWDUNKMANME_ID"]
  key = ENV["WWWDUNKMANME_KEY"]

  if id.nil? || key.nil?
    puts "S3 credentials not found in environment."
    exit 1
  end

  service = S3::Service.new(:access_key_id => id, :secret_access_key => key)
  bucket = service.buckets.find("www.dunkman.me")

  local_files = Dir["_site/**/*"].map { |file| file.sub(/_site\//, "") }
  remote_files = bucket.objects

  puts "Checking for local files to upload..."
  changes = false
  local_files.each do |local_file|
    next if File.directory? "_site/#{local_file}"
    files = remote_files.select { |remote_file| remote_file.key == local_file }
    remote_file = files.first

    if remote_file
      local_md5 = Digest::MD5.file("_site/#{local_file}").hexdigest
      remote_md5 = remote_file.etag

      unless local_md5 == remote_md5
        remote_file.content = open("_site/#{local_file}")
        remote_file.content_type = MIME::Types.of(local_file).first.content_type
        remote_file.save
        puts " |  #{local_file} has changed."
        changes = true
      end
    else
      remote_file = bucket.objects.build(local_file)
      remote_file.content = open("_site/#{local_file}")
      remote_file.content_type = MIME::Types.of(local_file).first.content_type
      remote_file.save
      puts " |  #{local_file} is new."
      changes = true
    end
  end

  unless changes
    puts "  (no files to upload)"
  end

  puts
  puts "Checking for remote files to delete..."
  changes = false
  remote_files.each do |remote_file|
    unless File.exists? "_site/#{remote_file.key}"
      remote_file.destroy
      puts " |  #{remote_file.key} has been removed."
      changes = true
    end
  end

  unless changes
    puts "  (no files to delete)"
  end

  puts
end
