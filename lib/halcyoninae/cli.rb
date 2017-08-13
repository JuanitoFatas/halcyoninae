require "halcyoninae/commander"
require "halcyoninae/parsers/arguments"
require "halcyoninae/parsers/options"

module Halcyoninae
  class CLI
    def initialize(program_name:, registries:, argv: ARGV)
      @program_name = program_name
      @registries = registries
      @argv = argv
    end

    def run
      Halcyoninae::Commander.new(
        program_name: program_name,
        registries: registries,
        arguments: arguments,
        options: options
      ).run
    end

    private
    attr_reader :program_name, :registries, :argv

    def arguments
      Halcyoninae::ArgumentsParser.new(argv).run
    end

    def options
      Halcyoninae::OptionsParser.new(argv).run
    end
  end
end
