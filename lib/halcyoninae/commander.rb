require "halcyoninae/support/find_command"
require "halcyoninae/io"

module Halcyoninae
  class Commander
    def initialize(program_name:, registries:, arguments:, options:)
      @program_name = program_name
      @registries = registries
      @arguments = arguments
      @options = options
    end

    # Find the registered command from argument(s)
    # If command has subcommand, prints all subcommands
    # If command has no subcommand, invoke the command
    def run
      if invoked_command.is_a? NoCommand
        print_commands(registries)
      elsif invoked_command.has_subcommands?
        print_commands(invoked_command.subcommands)
      else
        execute_command
      end
    end

    private
    attr_reader :program_name, :registries, :arguments, :options

    def io
      @_io ||= IO.new
    end

    def print_commands(commands, namespace: nil)
      io.puts "Commands:\n"
      commands.each do |name, klass|
        command = [namespace, name].compact.join(" ")
        print_command(command, klass)
      end
      exit(0)
    end

    def execute_command
      invoked_command.run(arguments, options)
    end

    def print_command(name, klass)
      if has_subcommand?(klass)
        io.puts "#{program_name} #{name} [SUBCOMMAND]".ljust(2)
      else
        command = klass.new
        required_argument = command.required_arguments.map &:name
        description = command.description
        io.puts "#{program_name} #{name} #{required_argument.join(" ")} # #{description}".ljust(2)
      end
    end

    def has_subcommand?(klass)
      klass.is_a? Hash
    end

    def invoked_command
      Halcyoninae::FindCommand.new(registries, arguments).run
    end
  end
end
