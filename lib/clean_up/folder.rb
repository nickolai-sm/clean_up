module CleanUp
  class Folder
    attr_reader :options, :strategy, :files_rules, :directory_rules

    def self.collect(strategy, &block)
      new(strategy, &block)
    end

    def source(folder = nil)
      @source ||= folder
    end

    def target(folder = nil)
      @target ||= folder
    end

    def initialize(strategy, &block)
      @strategy, @files_rules, @directory_rules = strategy, [], []
      instance_eval(&block)
    end

    def file(format = nil, &block)
      with_options(format, block) do
        @files_rules << file_rule_class.new(options)
      end
    end

    def directory(format, &block)
      with_options(format, block) do
        @directory_rules << directory_rule_class.new(options)
      end
    end

    def process_directory(directory)
      directory_rules.detect do |rule|
        rule.match?(directory) && rule.call(directory, source, target)
      end
    end

    def process_file(file)
      files_rules.detect do |rule|
        rule.match?(file) && rule.call(file, source, target)
      end
    end

    def file_rule_class
      strategy == :move ? Rules::MoveFile : Rules::CopyFile
    end

    def directory_rule_class
      strategy == :move ? Rules::MoveDirectory : Rules::CopyDirectory
    end

    def with_options(format, options_block)
      @options = CleanUp::OptionValues.parse(format, &options_block)

      yield if block_given?
    ensure
      @options = nil
    end
  end
end