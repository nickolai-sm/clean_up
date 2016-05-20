module CleanUp
  module Conditions
    class Contains
      def initialize(&block)
        @file_conditions = []
        instance_eval(&block)
      end

      def file(&block)
        @file_conditions << Conditions.build_for_file(OptionValues.parse(&block))
      end

      def match?(folder)
        entries = Dir.entries(folder) - IGNORED_ENTRIES
        files = entries.select { |entry| !File.directory?(entry) }

        match_file_conditions?(files)
      end

      def match_file_conditions?(files)
        @file_conditions.all? do |conditions|
          files.any? do |file|
            conditions.all? { |c| c.match?(file) }
          end
        end
      end
    end
  end
end