module CleanUp
  module Rules
    class MoveFile < Base
      def initialize(options)
        @conditions = Conditions.build_for_file(options)
        @options = options
      end

      def call(entry, target)
        if @conditions.all? { |c| c.match?(entry) }
          puts "Will move file `#{entry}` to folder `#{full_target_folder(target)}`."

          # FileUtils.mv(expand_file_path, full_target_folder, verbose: verbose)
          true
        end
      end

      private

      def full_target_folder(target)
        File.join(File.expand_path(target), options['dir'])
      end
    end
  end
end