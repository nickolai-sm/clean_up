require 'clean_up/conditions/extension'
require 'clean_up/conditions/contains'
require 'clean_up/conditions/pattern'
require 'clean_up/conditions/name'
require 'clean_up/conditions/size'

module CleanUp
  module Conditions
    #TODO created_at condition
    TYPES_CONDITIONS = {
      file: %w(name extension pattern size),
      folder: %w(contains name pattern)
    }

    class << self
      def build_for_file(options)
        build_by_type(:file, options)
      end

      def build_for_folder(options)
        build_by_type(:folder, options)
      end

      def build(type, *args)
        case type
        when 'pattern', 'size', 'name', 'extension'
          Conditions.const_get(type.capitalize).new(*args)
        when 'contains'
          Conditions::Contains.new(&args.first)
        end
      end

      protected

      def build_by_type(conditions_type, options)
        options.keys.each_with_object([]) do |type, memo|
          memo << build(type, *options.delete(type)) if TYPES_CONDITIONS[conditions_type].include?(type)
        end
      end
    end
  end
end