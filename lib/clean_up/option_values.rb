module CleanUp
  class OptionValues
    OPTIONS = %w(dir extension pattern files_amount size)

    attr_reader :options

    def self.parse(format, &block)
      new(format, &block).options
    end

    def initialize(format_value = nil, &block)
      @options = {}
      self.extension(format_value) if format_value
      instance_eval(&block)
    end

    def respond_to_missing?(method, *)
      method.to_s.in?(OPTIONS) || super
    end

    def method_missing(method, *args)
      @options[method.to_s] = args
    end
  end
end