---
title: Deploying static websites to Amazon S3
date: "2013-08-07"
summary: Amazon S3 is a great choice for hosting static content (like blogs), but the process of deploying can leave a little to be desired — unless you leverage a build tool like Rake.
aliases:
  - /code/deploying-static-websites-to-amazon-s3.html
  - /blog/2013/deploying-static-websites-to-amazon-s3.html
---

I recently switched hosting for this site --- from Heroku to Amazon S3. I’ve always used [Jekyll](http://jekyllrb.com/) to build it, but had been using Heroku for the convenience of push-to-deploy (I use custom plugins as well as SASS, so I’m unable to use [GitHub Pages](http://pages.github.com/) without mucking up my site’s git history).

My hesitation to use Amazon S3 has always been deploying --- I wanted something as simple as Heroku’s push-to-deploy. After a bit of struggling, I ended up writing a [Rake](http://rake.rubyforge.org/) task to do it all for me. To see the complete source (including the build task), check out [this site on GitHub](https://github.com/adunkman/dunkman.me/blob/master/Rakefile).

Rake task to deploy the `_site/` directory to an S3 bucket:

```ruby
desc "Deploy site to Amazon S3"
task :deploy => :build do
  require "s3"

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
        remote_file.content_type = "" # Use default
        remote_file.save
        puts " |  #{local_file} has changed."
        changes = true
      end
    else
      remote_file = bucket.objects.build(local_file)
      remote_file.content = open("_site/#{local_file}")
      remote_file.content_type = "" # Use default
      remote_file.save
      puts " |  #{local_file} is new."
      changes = true
    end

  end

  unless changes
    puts "  (no files to upload)"
  end

  puts
end
```
