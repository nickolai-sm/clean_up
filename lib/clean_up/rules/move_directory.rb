module CleanUp
  module Rules
    class MoveDirectory < MoveFile
      def initialize(options)
        @conditions = Conditions.build_for_folder(options)
        @options = options
      end

      def call(entry, target)
        if @conditions.all? { |c| c.match?(entry) }

          puts "Will move folder `#{entry}` to folder `#{full_target_folder(target)}`."

          # FileUtils.mv(expand_file_path, full_target_folder, verbose: verbose)
          true
        end
      end
    end
  end
end