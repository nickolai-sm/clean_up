require 'mime-types'

module CleanUp
  module Conditions
    class Format
      def initialize(value)
        @pattern = Array(value)
      end

      def match?(file)
        extension = MIME::Types.of(file).first
        
        extension && @pattern.include?(extension.preferred_extension)
      end
    end
  end
end