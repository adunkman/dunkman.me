module Jekyll
  module TwitterCard
    def to_twitter_description(markdown)
      strip_liquid(strip_html(markdownify(markdown)))
    end

    def strip_liquid(input)
      input.gsub(/\{%[^%]*%\}/, "")
    end
  end
end

Liquid::Template.register_filter(Jekyll::TwitterCard)
