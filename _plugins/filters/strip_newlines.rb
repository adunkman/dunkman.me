module Jekyll
  class StripNewlines < Liquid::Block
    def render(context)
      super.gsub(/\n\s*\n/, "\n")
    end
  end
end

Liquid::Template.register_tag('strip_newlines', Jekyll::StripNewlines)
