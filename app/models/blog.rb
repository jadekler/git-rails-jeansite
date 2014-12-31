class Blog < ActiveRecord::Base
    def smart_short
        if self.short
            self.short
        else
            first_markdown = self.content.index(/[`\[\(]/)
            end_character = first_markdown && first_markdown < 100 ? first_markdown-1 : 100
            self.content[0..end_character]
        end
    end
end
