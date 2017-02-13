module CleanUp
  module Conditions
    class File
      def initialize(conditions)
        @conditions = conditions
      end

      def match?(folder)
        FolderEntity.new(folder).files.any? do |file|
          @conditions.all? { |c| c.match?(file) }
        end
      end
    end
  end
end
