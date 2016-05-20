require 'mime-types'

module CleanUp
  module Conditions
    class Extension
      def initialize(*value)
        @pattern = *value
      end

      def match?(file)
        extension = MIME::Types.of(file).first # File.extname(file)

        extension && @pattern.include?(extension.preferred_extension)
      end
    end
  end
end