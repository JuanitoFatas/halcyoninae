# frozen_string_literal: true

module Halcyoninae
  class NoCommand
  end

  class FoundCommand
    attr_reader :name, :command_class

    def initialize(name, command_class)
      @name = name
      @command_class = command_class
    end

    def run(arguments, options)
      command_class.new(
        arguments: arguments,
        options: options,
        position: name.split(" ").size
      ).run
    end

    def has_subcommands?
      !!subcommands
    end

    def subcommands
      command_class
    end
  end

  class FindCommand
    def initialize(registered_commands, arguments)
      @registered_commands = registered_commands
      @arguments = arguments
    end

    def run
      if command_found?
        FoundCommand.new(name, registered_commands[name])
      else
        NoCommand.new
      end
    end

    private
    attr_reader :registered_commands, :arguments

    def command_found?
      !!name
    end

    def name
      possible_commands.each.find do |possible_command|
        lookup_from_registered_commands(possible_command)
      end
    end

    def possible_commands
      arguments.map.with_index do |_, index|
        arguments[0..index].join(" ")
      end.reverse
    end

    def lookup_from_registered_commands(possible_command)
      keys = possible_command.split(" ")
      registered_commands.fetch(*keys)
    end
  end
end
