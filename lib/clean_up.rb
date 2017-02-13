require 'clean_up/version'

require 'clean_up/context'
require 'clean_up/actions'
require 'clean_up/processor'
require 'clean_up/conditions'
require 'clean_up/folder_entity'
require 'clean_up/option_values'

module CleanUp
  class << self
    def define(&block)
      @context = Context::Directory.new(&block)
    end

    def rules
      @context || Context::Directory.new
    end

    def check
      rules.check_source_entry
    end
  end
end
