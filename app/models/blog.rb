class Blog < ActiveRecord::Base
    def smart_short
        if self.short
            self.short
        else
            self.content[0..100]
        end
    end
end
