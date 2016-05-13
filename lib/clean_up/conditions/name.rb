module Conditions
  class Name
    def initialize(value)
      @pattern = Array(value)
    end

    def match?(file)
      pattern == file
    end
  end
end