# encoding: utf-8
module Diacritics
  # Include this into String class
  module String
    def self.included(klass)
      klass.class_eval do
        def downcase
          Diacritics::Cases.instance.downcase self
        end

        def upcase
          Diacritics::Cases.instance.upcase self
        end
      end
    end

    def permanent(space_replace_char = '-')
      Diacritics::Cases.instance.permanent(self,space_replace_char)
    end

    def permanent?
      Diacritics::Cases.instance.permanent(self,'-') == self
    end

    def slug?
      return true if match(/^[[a-z\d_-]]+$/)
    end
  end
end
