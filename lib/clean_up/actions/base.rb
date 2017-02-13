module CleanUp
  module Actions
    class Base
      attr_reader :target, :folders, :file

      def initialize(target, *folders, **options)
        @target, @folders = target, folders
        @file = options[:file]
      end

      def call(_entry, _options)
        raise NotImplementedError
      end

      private

      def full_target_folder(folder)
        dirname = [File.absolute_path(target), folder].join(File::SEPARATOR)

        FileUtils.mkdir_p(dirname) unless File.exist?(dirname)

        dirname
      end
    end
  end
end
