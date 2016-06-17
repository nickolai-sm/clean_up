module CleanUp
  module Rules
    class MoveFile < Base
      def build_conditions(options)
        Conditions.build_for_file(options)
      end

      def call(entry, target)
        if match_conditions?(entry)
          puts "Will move file `#{entry}` to folder `#{full_target_folder(target)}`."

          true
        end
      end
    end
  end
end
