require 'clean_up/conditions/extension'
require 'clean_up/conditions/contains'
require 'clean_up/conditions/pattern'
require 'clean_up/conditions/name'

module CleanUp
  module Conditions
    #TODO: created_at, size conditions
    TYPES_CONDITIONS = {
      file: %w(name extension pattern),
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
        when 'pattern'
          Conditions::Pattern.new(*args)
        when 'name'
          Conditions::Name.new(*args)
        when 'extension'
          Conditions::Extension.new(*args)
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