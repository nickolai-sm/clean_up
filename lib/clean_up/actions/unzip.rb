require 'fileutils'
require 'zip'

module CleanUp
  module Actions
    class Unzip < Base
      attr_reader :encoding

      def initialize(target, *folders, **options)
        @target, @folders = target, folders
        @encoding = options[:encoding]
        Zip.on_exists_proc = true
      end

      def call(entry)
        folders.each do |folder|
          Zip::File.open(entry) do |zip_file|
            zip_file.each do |entry|
              # encode_name(entry)
              # puts "Extracting #{entry.name}"
              entry.extract(File.join(full_target_folder(folder), entry.name.encode('UTF-8', encoding)))

              # entry.extract(dest_file(entry))
            end
          end
        end
      end

      def encode_name(entry)
        file.name = file.name.encode('UTF-8', encoding)
      end

      def dest_file(entry)
        File.join(target, entry.name)
      end
    end
  end
end
