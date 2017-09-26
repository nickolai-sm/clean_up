module CleanUp
  module Context
    class Base
      SUPPORTED_OPTIONS = %w(dir extension pattern files_amount size encoding name).freeze

      attr_reader :options, :actions, :contexts, :conditions

      def self.parse(&block)
        new(&block).options
      end

      def initialize(target = nil, &block)
        @target     = target
        @conditions = []
        @contexts   = []
        @actions    = []
        @options    = {}

        instance_eval(&block) if block_given?
        build_conditions
      end

      # Implement setter & getter for source folder.
      def source(folder = nil)
        @source ||= ::File.expand_path(folder)
      end

      # Implement setter & getter for target folder.
      def target(folder = nil)
        @target ||= ::File.expand_path(folder)
      end

      def any_entry_match?(source)
        raise NotImplementedError
      end

      def all_entries_match?(source)
        raise NotImplementedError
      end

      def check_entry(folder)
        Processor.call(self, folder)
      end

      def apply_actions(_folder_entity)
        raise NotImplementedError, '#apply_actions should be implemented in child class'
      end

      def match_conditions?(_folder_entity)
        raise NotImplementedError, '#match_conditions? should be implemented in child class'
      end

      private

      def build_conditions
        raise NotImplementedError, '#build_conditions should be implemented in child class'
      end

      def respond_to_missing?(method, *)
        SUPPORTED_OPTIONS.include?(method.to_s) || super
      end

      def method_missing(method, *args)
        return unless SUPPORTED_OPTIONS.include?(method.to_s)

        @options[method.to_s] = OptionValues.build(method, args)
      end
    end
  end
end
