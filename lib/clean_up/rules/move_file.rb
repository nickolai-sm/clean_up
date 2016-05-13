module CleanUp
  module Rules
    class MoveFile < Base
      def call(entry, source, target)
        puts "Will move file `#{File.join(source, entry)}` to folder `#{full_target_folder(target)}`."

        # FileUtils.mv(expand_file_path, full_target_folder, verbose: verbose)
      end
      private

      def full_target_folder(target)
        File.join(File.expand_path(target), options['dir'])
      end
    end
  end
end