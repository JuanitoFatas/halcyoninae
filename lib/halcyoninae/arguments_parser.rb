# frozen_string_literal: true

module Halcyoninae
  class ArgumentsParser
    def initialize(argv)
      @left, @right = argv.slice_after(DOUBLE_DASH).to_a
    end

    def run
      parse_arguments
    end

    private
    attr_reader :left, :right

    DASH = "-"
    DOUBLE_DASH = "--" # https://goo.gl/qTPnwx

    def parse_arguments
      [arguments, right].flatten.compact
    end

    def arguments
      left.reject { |arg| option?(arg) }
    end

    def option?(arg)
      arg.start_with?(DASH) || arg.start_with?(DOUBLE_DASH)
    end
  end
end
