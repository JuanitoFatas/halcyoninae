require "halcyoninae"

require_relative "commands/new_command"
require_relative "commands/version_command"

module Kingfisher
  class CLI
    def start
      Halcyoninae::CLI.new(registries: { "new" => NewCommand, "version" => VersionCommand }).run
    end
  end
end
