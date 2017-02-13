require 'fileutils'

module CleanUp
  module Actions
    class Copy < Base
      def call(entry)
        folders.each do |folder|
          copy_entry(entry, folder)
        end
      end

      private

      def copy_entry(entry, folder)
        if file
          FileUtils.cp(entry, full_target_folder(folder), verbose: true)
        else
          FileUtils.cp_r(entry, full_target_folder(folder), verbose: true)
        end
      end
    end
  end
end
