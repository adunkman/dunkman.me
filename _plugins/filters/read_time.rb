module Jekyll
  module ReadTime
    def read_time(html)
      rate = 160
      words = number_of_words(html) + 0.0
      (words / rate).ceil
    end
  end
end

Liquid::Template.register_filter(Jekyll::ReadTime)
