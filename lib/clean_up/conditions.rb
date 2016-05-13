require 'clean_up/conditions/format'
require 'clean_up/conditions/name'

module CleanUp
  module Conditions
    def self.build(type, *args)
      case type
      when 'pattern', 'name'
        Conditions::Name.new(*args)
      when 'extension'
        Conditions::Format.new(*args)
      end
    end
  end
end