require 'fileutils'

module CleanUp
  module Actions
    class Convert < Base
      attr_reader :format

      def initialize(format)
        @format = format
      end

      def call(entry)
        extension = ::File.extname(entry)[1..-1]

        target_file = entry.gsub(extension, format)

        system("ffmpeg -i \"#{entry}\" -c:v libx264 -crf 19 -preset slow -c:a aac -strict experimental -b:a 192k -ac 2 \"#{target_file}\"")
      end
    end
  end
end
