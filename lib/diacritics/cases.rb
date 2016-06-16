# encoding: utf-8

# String core class
class String
  alias_method :old_downcase, :downcase
  alias_method :old_upcase, :upcase
end

# Diacritics classes
module Diacritics
  # Downcase or upcase with diacritics support
  class Cases
    def self.instance
      @instance ||= new
    end

    def initialize
      @alphabet = Diacritics::Alphabet.new
      @hash, @regexp = @alphabet.hash, @alphabet.regexp
      @space_replace_char = '-'
    end

    def downcase(text)
      text.old_downcase.gsub @regexp[:downcase], @hash[:downcase]
    end

    def upcase(text)
      text.old_upcase.gsub @regexp[:upcase], @hash[:upcase]
    end

    def permanent(text,space_replace_char)
      if space_replace_char != @space_replace_char
        @alphabet.reload_permanent(space_replace_char)
        @hash, @regexp = @alphabet.hash, @alphabet.regexp
        @space_replace_char = space_replace_char
      end
      text.old_downcase.gsub @regexp[:permanent], @hash[:permanent]
    end
  end
end
