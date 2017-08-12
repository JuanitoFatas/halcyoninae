# frozen_string_literal: true

module Halcyoninae
  class OptionsParser
    def initialize(argv)
      @argv = argv
    end

    def run
      parse_options
    end

    private
    attr_reader :argv

    EQUAL_SIGN = "="
    DASH = "-"
    DOUBLE_DASH = "--"

    def parse_options
      options.inject({}) do |hash, option|
        if option.include?(EQUAL_SIGN)
          key, value = option.split(EQUAL_SIGN)
          hash.merge(key => value)
        else
          hash.merge(option => true)
        end
      end
    end

    def options
      argv.select { |arg| option?(arg) }
    end

    def option?(arg)
      return false if arg == DOUBLE_DASH

      arg.start_with?(DASH) || arg.start_with?(DOUBLE_DASH)
    end
  end
end
