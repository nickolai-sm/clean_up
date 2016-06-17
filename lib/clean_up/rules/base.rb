module CleanUp
  module Rules
    class Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call(entry, source, target)
        raise NotImplementedError
      end
    end
  end
end
