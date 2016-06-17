module CleanUp
  module Rules
    class MoveFile < Base
      def build_conditions(_options)
        Conditions.build_for_file(options)
      end

      def call(entry, target)
        if match_conditions?
          FileUtils.mv(entry, full_target_folder(target), verbose: true)
        end
      end
    end
  end
end
