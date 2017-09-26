require 'fileutils'

module CleanUp
  module Actions
    class Move < Base
      def call(entry)
        folders.each do |folder|
          FileUtils.mv(entry, full_target_folder(folder), verbose: ENV['VERBOSE'])
        end
      end
    end
  end
end
