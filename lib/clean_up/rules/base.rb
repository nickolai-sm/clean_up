module CleanUp
  module Rules
    class Base
      SUPPORTED_CONDITIONS = %w(extension pattern)

      attr_reader :options

      def initialize(options)
        @conditions = options.keys.each_with_object([]) do |type, memo|
          memo << Conditions.build(type, options.delete(type)) if SUPPORTED_CONDITIONS.include?(type)
        end

        @options = options
      end

      def match?(entry)
        @conditions.all? { |c| c.match?(entry)}
      end

      def call(entry, source, target)
        raise NotImplementedError
      end
    end
  end
end