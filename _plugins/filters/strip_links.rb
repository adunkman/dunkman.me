module Jekyll
  module StripLinks
    def strip_links(input)
      input.gsub(/<a[^>]+>([^<]+)<\/a>/, '\1')
    end
  end
end

Liquid::Template.register_filter(Jekyll::StripLinks)
