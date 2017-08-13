require "halcyoninae"

require_relative "commands/kingfisher/new_command"
require_relative "commands/kingfisher/version_command"
require_relative "commands/kingfisher/controller_command"
require_relative "commands/kingfisher/model_command"

module Kingfisher
  class CLI
    def start
      Halcyoninae::CLI.new(program_name: "kingfisher", registries: command_registries).run
    end

    private

    def command_registries
      {
        "new" => NewCommand,
        "version" => VersionCommand,
        "generate" => {
          "controller" => ControllerCommand,
          "model" => ModelCommand
        }
      }
    end
  end
end
