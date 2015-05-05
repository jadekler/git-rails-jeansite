class Blog < ActiveRecord::Base
  def smart_short
    if self.short
      self.short
    else
      if self.content
        first_markdown = self.content.index(/[`\[\(]/)
        end_character = first_markdown && first_markdown < 110 ? first_markdown-1 : 110

        return self.content[0..end_character]
      else
        return ''
      end
    end
  end
end
