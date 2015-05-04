class Blog < ActiveRecord::Base
  def smart_short
    if self.short
      self.short
    else
      # first_markdown = self.content.index(/[`\[\(]/)
      # end_character = first_markdown && first_markdown < 110 ? first_markdown-1 : 110
      # self.content[0..end_character]
      'foo'
    end
  end
end
