module CleanUp
  module Rules
    class MoveDirectory < Base
      def build_conditions(options)
        Conditions.build_for_directory(options)
      end

      def call(entry, target)
        if match_conditions?(entry)
          puts "Will move folder `#{entry}` to folder `#{full_target_folder(target)}`."

          true
        end
      end
    end
  end
end
