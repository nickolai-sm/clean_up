module CleanUp
  class Processor
    attr_reader :context, :source

    def initialize(context, source)
      @context, @source = context, source
    end

    def call
       match_conditions? && match_sub_contexts? && applied_actions?
    end

    # private

    def match_conditions?
      context.match_conditions?(source)
    end

    def match_sub_contexts?
      return true if context.contexts.empty?

      context.contexts.all? do |sub_context|
        raise ArgumentError, 'Action already defined' if context.actions.any? && sub_context.actions.any?

        if sub_context.actions.empty?
          sub_context.any_entry_match?(source)
        else
          sub_context.all_entries_match?(source) # should return positive statement
        end
      end
    end

    def applied_actions?
      context.actions.empty? || context.apply_actions(source)
    end

    def self.call(context, source)
      new(context, source).call
    end
  end
end
