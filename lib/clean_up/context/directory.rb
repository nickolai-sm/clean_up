module CleanUp
  module Context
    class Directory < Base

      def file(&block)
        context = Context::File.new(target, &block)

        if context.actions.empty?
          @conditions << Conditions::File.new(context.conditions)
        else
          @contexts << context
        end
      end

      alias :contains_file :file

      def move_files_to(target_sub_folder, &block)
        context = Context::File.new(target, &block)

        context.move_to target_sub_folder

        @contexts << context
      end

      def copy_files_to(target_sub_folder, &block)
        context = Context::File.new(target, &block)

        context.copy_to target_sub_folder

        @contexts << context
      end

      def move_directories_to(target_sub_folder, &block)
        context = Context::Directory.new(target, &block)

        context.move_to target_sub_folder

        @contexts << context
      end

      def copy_directories_to(target_sub_folder, &block)
        context = Context::Directory.new(target, &block)

        context.copy_to target_sub_folder

        @contexts << context
      end

      def directory(&block)
        @contexts << Context::Directory.new(target, &block)
      end

      def move_to(*args)
        @actions << Actions::Move.new(target, *args)
      end

      def copy_to(*args)
        @actions << Actions::Copy.new(target, *args)
      end

      def any_entry_match?(source)
        source.folders.map { |folder| check_entry(CleanUp::FolderEntity.new(folder)) }.any?
      end

      def all_entries_match?(source)
        source.folders.each { |folder| check_entry(CleanUp::FolderEntity.new(folder)) }
      end

      def check_source_entry
        Processor.call(self, CleanUp::FolderEntity.new(source))
      end

      def apply_actions(folder_entity)
        actions.each do |action|
          action.call(folder_entity.source)
        end
      end

      def match_conditions?(folder_entity)
        @conditions.all? do |condition|
          condition.match?(folder_entity.source)
        end
      end

      private

      def build_conditions
        @conditions.push(*Conditions.build_for_directory(options))
      end
    end
  end
end
