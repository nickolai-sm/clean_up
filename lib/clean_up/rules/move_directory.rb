module CleanUp
  module Rules
    class MoveDirectory < MoveFile
      def initialize(options)
        @conditions = Conditions.build_for_directory(options)
        @options = options
      end

      def call(entry, target)
        if @conditions.all? { |c| c.match?(entry) }
          FileUtils.mv(entry, full_target_folder(target), verbose: true)
        end
      end
    end
  end
end
