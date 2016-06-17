module CleanUp
  module Rules
    class Base
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def call(_entry, _source, _target)
        raise NotImplementedError
      end
    end
  end
end
