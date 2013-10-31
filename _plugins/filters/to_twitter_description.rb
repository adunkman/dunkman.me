module Jekyll
  module TwitterCard
    def to_twitter_description(markdown)
      strip_html(markdownify(markdown))
    end
  end
end

Liquid::Template.register_filter(Jekyll::TwitterCard)
