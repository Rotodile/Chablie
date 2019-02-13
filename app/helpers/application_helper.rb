module ApplicationHelper
    def markdown(text)
        renderer = Redcarpet::Render::SmartyHTML.new(filter_html: true, 
                                                     hard_wrap: true, 
                                                     prettify: true)
        markdown = Redcarpet::Markdown.new(renderer, markdown_layout)
        markdown.render(sanitize(text)).html_safe
      end
      
      def markdown_layout
        { autolink: true, space_after_headers: true, no_intra_emphasis: true,
          tables: true, strikethrough: true, highlight: true, quote: true,
          fenced_code_blocks: true, disable_indented_code_blocks: true,
          lax_spacing: true }
     end
end
