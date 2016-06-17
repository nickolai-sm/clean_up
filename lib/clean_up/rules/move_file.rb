module CleanUp
  module Rules
    class MoveFile < Base
      def initialize(options)
        @conditions = Conditions.build_for_file(options)
        @options = options
      end

      def call(entry, target)
        if match_conditions?
          FileUtils.mv(entry, full_target_folder(target), verbose: true)
        end
      end

      private

      def match_conditions?
        @conditions.all? { |c| c.match?(entry) }
      end

      def full_target_folder(target)
        File.join(File.expand_path(target), options['dir'])
      end
    end
  end
end
