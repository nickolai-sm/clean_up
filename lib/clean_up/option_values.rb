# TODO: rename to OptionValue
module CleanUp
  class OptionValues
    def self.build(method, args)
      case method
      when 'dir'
        args.first.end_with?('/') ? args.first : "#{args.first}/"
      else
        args
      end
    end
  end
end
