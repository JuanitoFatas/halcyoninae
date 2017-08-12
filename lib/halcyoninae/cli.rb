require "halcyoninae/commander"
require "halcyoninae/arguments_parser"
require "halcyoninae/options_parser"

module Halcyoninae
  class CLI
    def initialize(registries:, argv: ARGV)
      @registries = registries
      @argv = argv
    end

    def run
      Halcyoninae::Commander.new(
        registries: registries,
        arguments: arguments,
        options: options
      ).run
    end

    private
    attr_reader :registries, :argv

    def arguments
      Halcyoninae::ArgumentsParser.new(argv).run
    end

    def options
      Halcyoninae::OptionsParser.new(argv).run
    end
  end
end
