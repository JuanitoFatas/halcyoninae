require "halcyoninae/command_registry"
require "halcyoninae/io"

module Halcyoninae
  class Commander
    def initialize(registries:, arguments:, options:)
      @registries = registries
      @arguments = arguments
      @options = options
    end

    def run
      command_class.new(
        arguments: arguments,
        options: options,
        position: command_name.split(" ").size
      ).run
    end

    private
    attr_reader :registries, :arguments, :options

    def command_class
      registries.fetch(command_name) do
        IO.new.puts "Command not found. Available commands: #{registries.keys.join(", ")}."
        exit(1)
      end
    end

    def command_name
      Halcyoninae::CommandRegistry.new(registries, arguments).find_command
    end
  end
end
