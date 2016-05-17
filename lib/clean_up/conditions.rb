require 'clean_up/conditions/extension'
require 'clean_up/conditions/pattern'
require 'clean_up/conditions/name'

module CleanUp
  module Conditions
    def self.build(type, *args)
      case type
      when 'pattern'
        Conditions::Pattern.new(*args)
      when 'name'
        Conditions::Name.new(*args)
      when 'extension'
        Conditions::Extension.new(*args)
      end
    end
  end
end