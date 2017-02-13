require 'fileutils'

module CleanUp
  module Actions
    class Move < Base
      def call(entry)
        folders.each do |folder|
          FileUtils.mv(entry, full_target_folder(folder), verbose: true)
        end
      end
    end
  end
end
