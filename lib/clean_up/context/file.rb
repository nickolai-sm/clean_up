module CleanUp
  module Context
    class File < Base
      def move_to(*args)
        @actions << Actions::Move.new(target, *args, file: true)
      end

      def copy_to(*args)
        @actions << Actions::Copy.new(target, *args, file: true)
      end

      def unzip_to(*args, **options)
        @actions << Actions::Unzip.new(target, *args, **options)
      end

      def convert_to(format)
        @actions << Actions::Convert.new(format)
      end

      def any_entry_match?(entry)
        check_entry(entry)
      end

      def all_entries_match?(entry)
        check_entry(entry)
      end

      def match_conditions?(folder_entity)
        folder_entity.files.any? do |file|
          conditions.all? { |condition| condition.match?(file) }
        end

        true
      end

      def apply_actions(folder_entity)
        folder_entity.files.each do |file|
          if conditions.all? { |condition| condition.match?(file) }
            actions.each { |action| action.call(file) }
          end
        end
      end

      private

      def build_conditions
        @conditions.push(*Conditions.build_for_file(options))
      end
    end
  end
end
