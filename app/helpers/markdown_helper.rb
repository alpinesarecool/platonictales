require "redcarpet"

module MarkdownHelper
  class HTMLWithPygments < Redcarpet::Render::HTML
    def initialize(options = {})
      super
      @options = options
    end
  end

  def markdown(text)
    renderer = HTMLWithPygments.new(filter_html: true, hard_wrap: true)
    options = {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      superscript: true,
      disable_indented_code_blocks: true,
    }
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end
end
